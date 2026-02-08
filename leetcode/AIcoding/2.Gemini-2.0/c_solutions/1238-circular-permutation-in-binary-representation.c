#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* circularPermutation(int n, int start, int* returnSize){
    int size = 1 << n;
    int* result = (int*)malloc(size * sizeof(int));
    *returnSize = size;

    for (int i = 0; i < size; i++) {
        result[i] = (i ^ (i >> 1)) ^ start;
    }

    return result;
}