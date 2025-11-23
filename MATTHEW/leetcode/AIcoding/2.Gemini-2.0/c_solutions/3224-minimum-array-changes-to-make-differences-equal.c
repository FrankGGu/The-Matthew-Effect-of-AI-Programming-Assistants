#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minChanges(int* nums, int numsSize, int k) {
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }
    int n = maxVal + 1;
    int dp[k + 1][n];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 1e9;
        }
    }

    for (int j = 0; j < n; j++) {
        int cnt = 0;
        for (int i = 0; i < numsSize; i++) {
            if (i % k == 0 && nums[i] == j) {
                cnt++;
            }
        }
        dp[1][j] = numsSize / k - cnt;
    }

    for (int i = 2; i <= k; i++) {
        for (int j = 0; j < n; j++) {
            int cnt = 0;
            for (int l = 0; l < numsSize; l++) {
                if (l % k == i - 1 && nums[l] == j) {
                    cnt++;
                }
            }
            dp[i][j] = dp[i - 1][0] + numsSize / k - cnt;

            for (int l = 0; l < n; l++) {
                if (l != j) {
                    int temp = dp[i - 1][l];
                    dp[i][j] = (dp[i][j] < temp + numsSize / k - cnt) ? dp[i][j] : (temp + numsSize / k - cnt);
                }
            }
        }
        int min_val = 1e9;
        for (int j = 0; j < n; j++) {
            if (dp[i-1][j] < min_val) {
                min_val = dp[i-1][j];
            }
        }
        for (int j = 0; j < n; j++) {
            int cnt = 0;
            for (int l = 0; l < numsSize; l++) {
                if (l % k == i - 1 && nums[l] == j) {
                    cnt++;
                }
            }
            dp[i][j] = (dp[i][j] < min_val + numsSize / k - cnt) ? dp[i][j] : (min_val + numsSize / k - cnt);
        }
    }

    int ans = 1e9;
    for (int j = 0; j < n; j++) {
        if (dp[k][j] < ans) {
            ans = dp[k][j];
        }
    }
    return ans;
}