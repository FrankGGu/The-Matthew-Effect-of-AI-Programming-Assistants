#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* largestDivisibleSubset(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int dp[numsSize];
    int prev[numsSize];
    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        prev[i] = i;
    }

    int max_index = 0;
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] % nums[j] == 0) {
                if (dp[i] < dp[j] + 1) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }
        if (dp[i] > dp[max_index]) {
            max_index = i;
        }
    }

    int* result = (int*)malloc(sizeof(int) * dp[max_index]);
    *returnSize = dp[max_index];

    int k = dp[max_index] - 1;
    int curr = max_index;
    while (curr != prev[curr]) {
        result[k] = nums[curr];
        curr = prev[curr];
        k--;
    }
    result[k] = nums[curr];

    return result;
}