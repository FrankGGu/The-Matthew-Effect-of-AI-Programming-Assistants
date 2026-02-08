#include <stdio.h>
#include <stdlib.h>

int* minBitwiseArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize - 1; i++) {
        int a = nums[i];
        int b = nums[i + 1];
        int min_val = (a & b) | (a | b);
        result[i] = min_val;
    }
    result[numsSize - 1] = nums[numsSize - 1];
    *returnSize = numsSize;
    return result;
}