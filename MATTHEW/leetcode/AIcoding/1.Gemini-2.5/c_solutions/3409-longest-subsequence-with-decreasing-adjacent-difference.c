#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int longestSubsequenceWithDecreasingAdjacentDifference(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    if (numsSize == 1) {
        return 1;
    }

    int** dp = (int**)malloc(numsSize * sizeof(int*));
    for (int k = 0; k < numsSize; ++k) {
        dp[k] = (int*)malloc(numsSize * sizeof(int));
    }

    int max_len = 1;

    for (int j = 1; j < numsSize; ++j) {
        for (int i = 0; i < j; ++i) {
            dp[j][i] = 2; 

            long long current_diff = (long long)nums[j] - nums[i];

            for (int k = 0; k < i; ++k) {
                long long prev_diff = (long long)nums[i] - nums[k];
                if (prev_diff > current_diff) {
                    dp[j][i] = max(dp[j][i], 1 + dp[i][k]);
                }
            }
            max_len = max(max_len, dp[j][i]);
        }
    }

    for (int k = 0; k < numsSize; ++k) {
        free(dp[k]);
    }
    free(dp);

    return max_len;
}