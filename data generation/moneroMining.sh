#!/bin/bash 

if [ $# -lt 1 ]
then
    echo "usage: $0 <config>"
    exit
fi

. $1



echo "walletAdress = $walletAdress"
echo "start = $start"
echo "end = $end"
echo "duration = $duration s"
echo "interval = $interval s"
echo "nonce = $nonce"
echo "#############################################"

mining_log_dir="mining_log_dir_$nonce"

rm -r $mining_log_dir
mkdir $mining_log_dir

ip_file="poolIP.txt"

for i in `seq $start $end`
do
    file_name="$i"
    
    echo "----------start-Mining-$i---------"
    ./xmrig/build/xmrig -o pool.minexmr.com:443 --tls -u $walletAdress |cat > $mining_log_dir/$file_name & read -t $duration || pkill xmrig
    
    grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $mining_log_dir/$file_name >> $mining_log_dir/$ip_file

    sleep $interval
    echo "----------end---Mining-$i---------"

done