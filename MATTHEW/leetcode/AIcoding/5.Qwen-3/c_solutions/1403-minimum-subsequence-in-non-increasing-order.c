#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int* minSubsequence(int* nums, int numsSize, int* returnSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    int currentSum = 0;
    int index = 0;
    while (currentSum <= sum - currentSum) {
        currentSum += nums[index];
        index++;
    }

    int* result = (int*)malloc(index * sizeof(int));
    for (int i = 0; i < index; i++) {
        result[i] = nums[i];
    }

    *returnSize = index;
    return result;
}