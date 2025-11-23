#include <limits.h>

int minimumOperations(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int counts[n][10];
    for (int j = 0; j < n; ++j) {
        for (int d = 0; d < 10; ++d) {
            counts[j][d] = 0;
        }
    }

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            counts[j][grid[i][j]]++;
        }
    }

    int cost[n][10];
    for (int j = 0; j < n; ++j) {
        for (int d = 0; d < 10; ++d) {
            cost[j][d] = m - counts[j][d];
        }
    }

    int dp[n][10];

    for (int d = 0; d < 10; ++d) {
        dp[0][d] = cost[0][d];
    }

    for (int j = 1; j < n; ++j) {
        int min1_val = INT_MAX, min2_val = INT_MAX;
        int min1_idx = -1;

        for (int prev_d = 0; prev_d < 10; ++prev_d) {
            if (dp[j-1][prev_d] < min1_val) {
                min2_val = min1_val;
                min1_val = dp[j-1][prev_d];
                min1_idx = prev_d;
            } else if (dp[j-1][prev_d] < min2_val) {
                min2_val = dp[j-1][prev_d];
            }
        }

        for (int current_d = 0; current_d < 10; ++current_d) {
            if (current_d != min1_idx) {
                dp[j][current_d] = cost[j][current_d] + min1_val;
            } else {
                dp[j][current_d] = cost[j][current_d] + min2_val;
            }
        }
    }

    int min_total_ops = INT_MAX;
    for (int d = 0; d < 10; ++d) {
        if (dp[n-1][d] < min_total_ops) {
            min_total_ops = dp[n-1][d];
        }
    }

    return min_total_ops;
}