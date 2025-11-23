#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxCoins(int* nums, int numsSize) {
    int n = numsSize;
    int new_nums[n + 2];
    new_nums[0] = 1;
    new_nums[n + 1] = 1;
    for (int i = 0; i < n; i++) {
        new_nums[i + 1] = nums[i];
    }

    int dp[n + 2][n + 2];
    for (int i = 0; i <= n + 1; i++) {
        for (int j = 0; j <= n + 1; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len <= n + 1; len++) {
        for (int i = 0; i <= n + 1 - len; i++) {
            int j = i + len;
            for (int k = i + 1; k < j; k++) {
                dp[i][j] = (dp[i][j] > dp[i][k] + new_nums[i] * new_nums[k] * new_nums[j] + dp[k][j]) ? dp[i][j] : dp[i][k] + new_nums[i] * new_nums[k] * new_nums[j] + dp[k][j];
            }
        }
    }

    return dp[0][n + 1];
}