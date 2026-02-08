#include <limits.h>
#include <stdlib.h>

int minFallingPathSum(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;

    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return grid[0][0];
    }

    int* prev_dp = (int*)malloc(n * sizeof(int));
    int* curr_dp = (int*)malloc(n * sizeof(int));

    for (int c = 0; c < n; c++) {
        prev_dp[c] = grid[0][c];
    }

    for (int r = 1; r < n; r++) {
        int min1_val = INT_MAX, min2_val = INT_MAX;
        int min1_idx = -1;

        for (int c = 0; c < n; c++) {
            if (prev_dp[c] < min1_val) {
                min2_val = min1_val;
                min1_val = prev_dp[c];
                min1_idx = c;
            } else if (prev_dp[c] < min2_val) {
                min2_val = prev_dp[c];
            }
        }

        for (int c = 0; c < n; c++) {
            if (c == min1_idx) {
                curr_dp[c] = grid[r][c] + min2_val;
            } else {
                curr_dp[c] = grid[r][c] + min1_val;
            }
        }

        for (int c = 0; c < n; c++) {
            prev_dp[c] = curr_dp[c];
        }
    }

    int overall_min_sum = INT_MAX;
    for (int c = 0; c < n; c++) {
        if (prev_dp[c] < overall_min_sum) {
            overall_min_sum = prev_dp[c];
        }
    }

    free(prev_dp);
    free(curr_dp);

    return overall_min_sum;
}