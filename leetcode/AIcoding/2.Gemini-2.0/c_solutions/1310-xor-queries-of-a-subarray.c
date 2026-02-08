#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* xorQueries(int* arr, int arrSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize){
    int *prefix_xor = (int*)malloc(sizeof(int) * (arrSize + 1));
    prefix_xor[0] = 0;
    for(int i = 0; i < arrSize; i++){
        prefix_xor[i+1] = prefix_xor[i] ^ arr[i];
    }

    int *result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;

    for(int i = 0; i < queriesSize; i++){
        int left = queries[i][0];
        int right = queries[i][1];
        result[i] = prefix_xor[right+1] ^ prefix_xor[left];
    }

    return result;
}