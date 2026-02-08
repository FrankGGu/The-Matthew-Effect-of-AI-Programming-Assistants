#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int maxConsecutive(int* coins, int coinsSize){
    qsort(coins, coinsSize, sizeof(int), cmpfunc);
    int res = 1;
    for (int i = 0; i < coinsSize; i++) {
        if (coins[i] <= res) {
            res += coins[i];
        } else {
            break;
        }
    }
    return res;
}