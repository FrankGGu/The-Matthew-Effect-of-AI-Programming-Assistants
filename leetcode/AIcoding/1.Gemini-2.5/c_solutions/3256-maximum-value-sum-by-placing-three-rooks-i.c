#include <limits.h> // For LLONG_MIN
#include <stdlib.h> // For malloc, free
#include <stdio.h>  // For NULL (though not strictly needed for the solution logic)

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maxValueSum(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        return 0;
    }

    int m = gridSize;
    int n = gridColSize[0];

    // If m < 3 or n < 3, it's impossible to place 3 rooks such that r1 < r2 < r3 and c1 < c2 < c3.
    // In such cases, the maximum sum would be 0 (if no valid placement, or all values are negative and 0 is the default).
    // If the problem implies non-negative values, 0 is a safe default.
    // If negative values are allowed and no valid placement exists, LLONG_MIN might be more appropriate.
    // For LeetCode "max sum" problems, 0 is often returned if no valid combination can be formed.
    if (m < 3 || n < 3) {
        return 0;
    }

    // dp[r][c] stores the maximum sum for k rooks, with the k-th rook at (r, c),
    // and all previous k-1 rooks at (prev_r, prev_c) where prev_r < r and prev_c < c.
    // We use two sets of DP arrays to optimize space: one for current k, one for previous k.
    long long** dp_curr = (long long**)malloc(m * sizeof(long long*));
    long long** max_prefix_curr = (long long**)malloc(m * sizeof(long long*));
    long long** dp_prev = (long long**)malloc(m * sizeof(long long*));
    long long** max_prefix_prev = (long long**)malloc(m * sizeof(long long*));

    for (int i = 0; i < m; ++i) {
        dp_curr[i] = (long long*)malloc(n * sizeof(long long));
        max_prefix_curr[i] = (long long*)malloc(n * sizeof(long long));
        dp_prev[i] = (long long*)malloc(n * sizeof(long long));
        max_prefix_prev[i] = (long long*)malloc(n * sizeof(long long));
    }

    long long overall_max_sum = LLONG_MIN;

    // k = 1: Place the first rook
    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            dp_prev[r][c] = grid[r][c]; // dp_prev now holds dp values for k=1

            // Compute max_prefix_prev for k=1
            long long val_above = (r > 0) ? max_prefix_prev[r - 1][c] : LLONG_MIN;
            long long val_left = (c > 0) ? max_prefix_prev[r][c - 1] : LLONG_MIN;
            max_prefix_prev[r][c] = max(dp_prev[r][c], max(val_above, val_left));
        }
    }

    // k = 2 and k = 3
    for (int k = 2; k <= 3; ++k) {
        overall_max_sum = LLONG_MIN; // Reset for current k calculation

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                dp_curr[r][c] = LLONG_MIN; // Initialize with min value
                if (r > 0 && c > 0) {
                    long long prev_max_val = max_prefix_prev[r - 1][c - 1];
                    if (prev_max_val != LLONG_MIN) { // Ensure a valid previous rook sum exists
                        dp_curr[r][c] = prev_max_val + grid[r][c];
                    }
                }

                // Compute max_prefix_curr for current k
                long long val_above = (r > 0) ? max_prefix_curr[r - 1][c] : LLONG_MIN;
                long long val_left = (c > 0) ? max_prefix_curr[r][c - 1] : LLONG_MIN;
                max_prefix_curr[r][c] = max(dp_curr[r][c], max(val_above, val_left));

                // If it's the last rook (k=3), update overall_max_sum
                if (k == 3) {
                    overall_max_sum = max(overall_max_sum, dp_curr[r][c]);
                }
            }
        }

        // Swap dp_curr and dp_prev for the next iteration
        long long** temp_dp = dp_prev;
        dp_prev = dp_curr;
        dp_curr = temp_dp;

        long long** temp_max_prefix = max_prefix_prev;
        max_prefix_prev = max_prefix_curr;
        max_prefix_curr = temp_max_prefix;
    }

    // Free memory
    for (int i = 0; i < m; ++i) {
        free(dp_curr[i]);
        free(max_prefix_curr[i]);
        free(dp_prev[i]);
        free(max_prefix_prev[i]);
    }
    free(dp_curr);
    free(max_prefix_curr);
    free(dp_prev);
    free(max_prefix_prev);

    // If no valid placement was found (e.g., all sums were LLONG_MIN due to no valid previous states),
    // return 0. This is a common LeetCode pattern for "max sum" problems when no items can be picked.
    if (overall_max_sum == LLONG_MIN) {
        return 0;
    }

    return overall_max_sum;
}