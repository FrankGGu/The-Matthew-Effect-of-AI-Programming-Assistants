#include <stdlib.h>

int* runningSum(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    if (numsSize == 0) {
        *returnSize = 0;
        return result;
    }

    result[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        result[i] = result[i - 1] + nums[i];
    }

    *returnSize = numsSize;
    return result;
}