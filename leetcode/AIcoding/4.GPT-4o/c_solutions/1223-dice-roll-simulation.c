#include <stdio.h>
#include <stdlib.h>

int* simulateDiceRolls(int n, int* returnSize){
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    for(int i = 0; i < n; i++){
        result[i] = rand() % 6 + 1;
    }
    return result;
}