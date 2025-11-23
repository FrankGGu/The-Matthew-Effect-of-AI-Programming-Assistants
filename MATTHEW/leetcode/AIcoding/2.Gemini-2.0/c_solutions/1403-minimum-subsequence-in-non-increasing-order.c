#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return *(int *)b - *(int *)a;
}

int* minSubsequence(int* nums, int numsSize, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    int currentSum = 0;
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        currentSum += nums[i];
        result[(*returnSize)++] = nums[i];
        totalSum -= nums[i];
        if (currentSum > totalSum) {
            return result;
        }
    }

    return result;
}