#! /bin/sh
#
# mass_encrypt.sh
# Created by vladimir, 2018

# Change colors of output
RED='\033[0;31m'
NC='\033[0m'

# A short HowTo
if [ $# -ne 1 -a $# -ne 2 ];    
    then 
        echo "=========================================================================="
        echo "Specify all the params"
        echo "Usage: ./mass_encrypt.sh /path/to/bin/folder/ /path/to/output/wbfw/folder/"
        echo "=========================================================================="
        exit 1
fi

# Encrypt firmwares and check compatibility
FileCounter=0
IterationCounter=0
for f in "$1"*.bin; do
    let FileCounter+=1
    ./encrypter keys $f
        if (./encrypter keys $f|grep "Blocks count" );
                then 
                    let IterationCounter+=1
                else
                    echo -e "${RED}$f is unsupported${NC}"
        fi
done
mv "$1"*.wbfw "$2" 

# Print results
if [ $? -ne 0 ];
    then 
        echo -e "${RED}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        echo "!!!!!!!!!!!!!!!Error!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        echo -e "!!!!Check a keyfile or firmwares presence!!!!!!${NC}"
    else
        echo "================================================================"    
        echo "Successfully encrypted $IterationCounter of $FileCounter  files!"
        echo "================================================================"
fi
