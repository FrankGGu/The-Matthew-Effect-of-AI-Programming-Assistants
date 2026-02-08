#include <stdlib.h>

int* distributeArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int half = numsSize / 2;
    int i, j = 0;

    for (i = 0; i < numsSize; i++) {
        if (i < half) {
            result[j++] = nums[i];
        }
    }

    for (i = 0; i < numsSize; i++) {
        if (i >= half) {
            result[j++] = nums[i];
        }
    }

    *returnSize = numsSize;
    return result;
}