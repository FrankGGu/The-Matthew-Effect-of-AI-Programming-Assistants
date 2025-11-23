#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int getMoneyAmount(int n) {
    int dp[n + 1][n + 1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len <= n; len++) {
        for (int start = 1; start <= n - len + 1; start++) {
            int end = start + len - 1;
            dp[start][end] = INT_MAX;
            for (int pivot = start; pivot <= end; pivot++) {
                int cost = pivot;
                if (pivot > start) {
                    cost += dp[start][pivot - 1];
                }
                if (pivot < end) {
                    cost += dp[pivot + 1][end];
                }
                if (cost < dp[start][end]) {
                    dp[start][end] = cost;
                }
            }
        }
    }
    return dp[1][n];
}