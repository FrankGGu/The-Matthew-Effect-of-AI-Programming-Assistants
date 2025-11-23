#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCount(int* coins, int coinsSize){
    int count = 0;
    for(int i = 0; i < coinsSize; i++){
        count += (coins[i] + 1) / 2;
    }
    return count;
}