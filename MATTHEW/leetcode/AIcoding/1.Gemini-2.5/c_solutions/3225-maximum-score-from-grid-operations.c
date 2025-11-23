#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MIN
#include <string.h> // For memcpy

int maxScore(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 0) {
        return 0;
    }

    // dp[j] stores the maximum score ending at column j for the current row.
    // We only need to store the previous row's DP values for space optimization.
    long long* prev_dp = (long long*)malloc(n * sizeof(long long));
    long long* curr_dp = (long long*)malloc(n * sizeof(long long));

    // Base case: Initialize prev_dp with values from the first row of the grid.
    for (int j = 0; j < n; ++j) {
        prev_dp[j] = grid[0][j];
    }

    // Iterate through rows starting from the second row (index 1).
    for (int i = 1; i < m; ++i) {
        long long max1_val = LLONG_MIN; // Stores the largest DP value from the previous row.
        int max1_idx = -1;             // Stores the column index corresponding to max1_val.
        long long max2_val = LLONG_MIN; // Stores the second largest DP value from the previous row.

        // Find the largest and second largest values in prev_dp.
        for (int j = 0; j < n; ++j) {
            if (prev_dp[j] > max1_val) {
                max2_val = max1_val; // The old max1_val becomes the new max2_val.
                max1_val = prev_dp[j];
                max1_idx = j;
            } else if (prev_dp[j] > max2_val) {
                // If prev_dp[j] is not greater than max1_val, but is greater than max2_val, update max2_val.
                max2_val = prev_dp[j];
            }
        }

        // Calculate curr_dp for the current row based on prev_dp.
        for (int j = 0; j < n; ++j) {
            if (j == max1_idx) {
                // If the current column j is the same as the column that yielded max1_val in the previous row,
                // we must use max2_val to satisfy the constraint (j != k).
                curr_dp[j] = (long long)grid[i][j] + max2_val;
            } else {
                // Otherwise, we can use max1_val from the previous row.
                curr_dp[j] = (long long)grid[i][j] + max1_val;
            }
        }

        // Copy curr_dp to prev_dp to prepare for the next iteration.
        memcpy(prev_dp, curr_dp, n * sizeof(long long));
    }

    // After processing all rows, the maximum score is the maximum value in the last row's DP array (prev_dp).
    long long overall_max_score = LLONG_MIN;
    for (int j = 0; j < n; ++j) {
        if (prev_dp[j] > overall_max_score) {
            overall_max_score = prev_dp[j];
        }
    }

    // Free dynamically allocated memory.
    free(prev_dp);
    free(curr_dp);

    // Return the maximum score, cast to int as required by the function signature.
    // Note: If the problem guarantees a non-negative score, and LLONG_MIN is returned,
    // it implies no valid path could be formed, possibly due to n=1 and strict constraints.
    return (int)overall_max_score;
}