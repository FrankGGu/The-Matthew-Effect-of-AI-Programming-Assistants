#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getFinalArray(int* nums, int numsSize, int queries[][2], int queriesSize, int* queriesColSize, int k, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
    }

    for (int i = 0; i < queriesSize; i++) {
        int index = queries[i][0];
        int value = queries[i][1];
        result[index] = result[index] * value;
    }

    *returnSize = numsSize;
    return result;
}