#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxBursts(int* nums, int numsSize) {
    int n = numsSize;
    int dp[n][n];
    for (int i = 0; i < n; i++) {
        dp[i][i] = nums[i];
    }
    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            dp[i][j] = 0;
            for (int k = i; k <= j; k++) {
                int left = (k == i) ? 0 : dp[i][k-1];
                int right = (k == j) ? 0 : dp[k+1][j];
                int current = (k == 0 ? 0 : nums[k-1]) + (k == n-1 ? 0 : nums[k+1]);
                dp[i][j] = fmax(dp[i][j], left + right + current * (j - i + 1));
            }
        }
    }
    return dp[0][n-1];
}

int maxBursts(int* nums, int numsSize) {
    int n = numsSize;
    int dp[n][n];
    for (int i = 0; i < n; i++) {
        dp[i][i] = nums[i];
    }
    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            dp[i][j] = 0;
            for (int k = i; k <= j; k++) {
                int left = (k == i) ? 0 : dp[i][k-1];
                int right = (k == j) ? 0 : dp[k+1][j];
                int current = (k == 0 ? 0 : nums[k-1]) + (k == n-1 ? 0 : nums[k+1]);
                dp[i][j] = fmax(dp[i][j], left + right + current * (j - i + 1));
            }
        }
    }
    return dp[0][n-1];
}