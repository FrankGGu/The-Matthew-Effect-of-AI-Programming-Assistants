#include <stdio.h>
#include <stdlib.h>

int dp[1000][1000];

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int stoneGameV(int* values, int valuesSize) {
    int n = valuesSize;
    for (int i = 0; i < n; i++) {
        dp[i][i] = 0;
    }

    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            int sum = 0;
            for (int k = i; k < j; k++) {
                sum += values[k];
            }
            dp[i][j] = 0;
            for (int k = i; k < j; k++) {
                int left = 0;
                for (int m = i; m <= k; m++) {
                    left += values[m];
                }
                int right = sum - left;
                if (left > right) {
                    dp[i][j] = max(dp[i][j], dp[i][k] + right);
                } else if (left < right) {
                    dp[i][j] = max(dp[i][j], dp[k + 1][j] + left);
                } else {
                    dp[i][j] = max(dp[i][j], dp[i][k] + right);
                    dp[i][j] = max(dp[i][j], dp[k + 1][j] + left);
                }
            }
        }
    }

    return dp[0][n - 1];
}