#include <stdio.h>
#include <stdlib.h>

int maxOperations(int* nums, int numsSize) {
    int n = numsSize;
    int dp[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 0; i < n - 1; i++) {
        dp[i][i + 1] = 1;
    }

    for (int length = 3; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            if (nums[i] + nums[j] == nums[i + 1] + nums[j - 1]) {
                dp[i][j] = dp[i + 1][j - 1] + 1;
            } else {
                dp[i][j] = 0;
            }
        }
    }

    int max_ops = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            max_ops = (dp[i][j] > max_ops) ? dp[i][j] : max_ops;
        }
    }

    return max_ops;
}