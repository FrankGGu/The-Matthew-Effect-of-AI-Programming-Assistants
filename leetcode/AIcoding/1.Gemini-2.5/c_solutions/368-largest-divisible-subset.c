#include <stdlib.h>

int compareIntegers(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* largestDivisibleSubset(int* nums, int numsSize, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(nums, numsSize, sizeof(int), compareIntegers);

    int* dp = (int*)malloc(numsSize * sizeof(int));
    int* prev = (int*)malloc(numsSize * sizeof(int));

    int max_len = 0;
    int last_idx = -1;

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        prev[i] = -1;
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            if (nums[i] % nums[j] == 0) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }
        if (dp[i] > max_len) {
            max_len = dp[i];
            last_idx = i;
        }
    }

    int* result = (int*)malloc(max_len * sizeof(int));
    *returnSize = max_len;

    int current_idx = last_idx;
    for (int i = max_len - 1; i >= 0; i--) {
        result[i] = nums[current_idx];
        current_idx = prev[current_idx];
    }

    free(dp);
    free(prev);

    return result;
}