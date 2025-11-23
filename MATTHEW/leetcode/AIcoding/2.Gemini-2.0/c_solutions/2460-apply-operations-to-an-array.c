#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* applyOperations(int* nums, int numsSize, int* returnSize) {
    for (int i = 0; i < numsSize - 1; i++) {
        if (nums[i] == nums[i + 1]) {
            nums[i] *= 2;
            nums[i + 1] = 0;
        }
    }

    int* result = (int*)malloc(numsSize * sizeof(int));
    int index = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != 0) {
            result[index++] = nums[i];
        }
    }

    for (int i = index; i < numsSize; i++) {
        result[i] = 0;
    }

    *returnSize = numsSize;
    for (int i = 0; i < numsSize; i++)
    {
        nums[i] = result[i];
    }
    free(result);
    return nums;
}