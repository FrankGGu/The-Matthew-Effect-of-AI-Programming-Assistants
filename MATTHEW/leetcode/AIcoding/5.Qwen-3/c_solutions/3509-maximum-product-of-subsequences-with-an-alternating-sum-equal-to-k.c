#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int maxProductSubsequence(int* nums, int numsSize, int k) {
    int** dp = (int**)malloc((numsSize + 1) * sizeof(int*));
    for (int i = 0; i <= numsSize; i++) {
        dp[i] = (int*)malloc((k + 1) * sizeof(int));
        for (int j = 0; j <= k; j++) {
            dp[i][j] = INT_MIN;
        }
    }

    for (int i = 0; i <= numsSize; i++) {
        dp[i][0] = 1;
    }

    for (int i = 1; i <= numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j >= nums[i - 1]) {
                dp[i][j] = (dp[i - 1][j - nums[i - 1]] != INT_MIN) ? (dp[i - 1][j - nums[i - 1]] * nums[i - 1]) : dp[i][j];
            }
        }
    }

    int result = dp[numsSize][k];
    for (int i = 0; i <= numsSize; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}