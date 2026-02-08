#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int maxSubsetSum(int* nums, int numsSize, int limit) {
    qsort(nums, numsSize, sizeof(int), compare);
    int sum = 0, count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (sum + nums[i] <= limit) {
            sum += nums[i];
            count++;
        } else {
            break;
        }
    }
    return count;
}

int maxLength(int* nums, int numsSize, int* query, int querySize, int* returnSize) {
    int* result = (int*)malloc(querySize * sizeof(int));
    for (int i = 0; i < querySize; i++) {
        result[i] = maxSubsetSum(nums, numsSize, query[i]);
    }
    *returnSize = querySize;
    return result;
}