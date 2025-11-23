#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* numberGame(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i += 2) {
        if (nums[i] < nums[i + 1]) {
            result[i] = nums[i + 1];
            result[i + 1] = nums[i];
        } else {
            result[i] = nums[i + 1];
            result[i + 1] = nums[i];
        }
    }

    return result;
}