#include <stdio.h>
#include <stdlib.h>

int* applyOperations(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    int index = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != 0) {
            result[index++] = nums[i];
        }
    }
    while (index < numsSize) {
        result[index++] = 0;
    }
    return result;
}