#include <stdio.h>
#include <stdlib.h>

int* productExceptSelf(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));

    int left = 1;
    for (int i = 0; i < numsSize; i++) {
        result[i] = left;
        left *= nums[i];
    }

    int right = 1;
    for (int i = numsSize - 1; i >= 0; i--) {
        result[i] *= right;
        right *= nums[i];
    }

    return result;
}