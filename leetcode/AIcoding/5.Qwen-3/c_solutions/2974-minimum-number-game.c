#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* minNumber(int* nums, int numsSize, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i += 2) {
        result[i] = nums[i + 1];
        result[i + 1] = nums[i];
    }
    *returnSize = numsSize;
    return result;
}