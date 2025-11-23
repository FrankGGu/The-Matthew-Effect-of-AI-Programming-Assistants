#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int maxIceCream(int* costs, int costsSize, int coins){
    qsort(costs, costsSize, sizeof(int), cmpfunc);
    int count = 0;
    for(int i = 0; i < costsSize; i++){
        if(coins >= costs[i]){
            coins -= costs[i];
            count++;
        } else {
            break;
        }
    }
    return count;
}