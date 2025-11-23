#include <stdio.h>
#include <stdlib.h>

int* rearrangeArray(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    int i, j = 0, k = 1;
    for (i = 0; i < numsSize; i += 2) {
        result[j++] = nums[i];
        if (i + 1 < numsSize)
            result[k++] = nums[i + 1];
    }
    return result;
}