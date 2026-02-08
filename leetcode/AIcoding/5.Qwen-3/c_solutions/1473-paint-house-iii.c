#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int solve(int** costs, int m, int n, int target) {
    int** dp = (int**)malloc(sizeof(int*) * (target + 1));
    for (int i = 0; i <= target; i++) {
        dp[i] = (int*)malloc(sizeof(int) * n);
        for (int j = 0; j < n; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    for (int j = 0; j < n; j++) {
        dp[0][j] = costs[0][j];
    }

    for (int i = 1; i < m; i++) {
        int** new_dp = (int**)malloc(sizeof(int*) * (target + 1));
        for (int k = 0; k <= target; k++) {
            new_dp[k] = (int*)malloc(sizeof(int) * n);
            for (int j = 0; j < n; j++) {
                new_dp[k][j] = INT_MAX;
            }
        }

        for (int k = 0; k <= target; k++) {
            for (int j = 0; j < n; j++) {
                if (k == 0) {
                    new_dp[k][j] = costs[i][j];
                } else {
                    for (int prev_j = 0; prev_j < n; prev_j++) {
                        if (prev_j != j && dp[k - 1][prev_j] != INT_MAX) {
                            new_dp[k][j] = min(new_dp[k][j], dp[k - 1][prev_j] + costs[i][j]);
                        }
                    }
                }
            }
        }

        for (int k = 0; k <= target; k++) {
            free(dp[k]);
        }
        free(dp);
        dp = new_dp;
    }

    int result = INT_MAX;
    for (int j = 0; j < n; j++) {
        result = min(result, dp[target][j]);
    }

    for (int k = 0; k <= target; k++) {
        free(dp[k]);
    }
    free(dp);

    return result;
}

int main() {
    return 0;
}