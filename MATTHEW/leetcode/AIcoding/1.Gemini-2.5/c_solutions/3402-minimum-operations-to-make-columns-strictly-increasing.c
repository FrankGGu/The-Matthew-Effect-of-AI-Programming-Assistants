#include <limits.h>
#include <stdlib.h>

int minOperations(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    // dp[i][s] stores the minimum total shifts for rows 0 to i,
    // such that row i is shifted 's' times, and all columns 0 to n-1
    // are strictly increasing up to row i.
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int s = 0; s < n; s++) {
            dp[i][s] = INT_MAX;
        }
    }

    // Base case: For the first row (row 0)
    // The cost is just the number of shifts 's' for row 0.
    // There are no previous rows to compare against, so any shift is valid.
    for (int s = 0; s < n; s++) {
        dp[0][s] = s;
    }

    // Fill the DP table for subsequent rows
    for (int i = 1; i < m; i++) { // Current row index
        for (int s = 0; s < n; s++) { // Shifts for current row 'i'
            for (int prev_s = 0; prev_s < n; prev_s++) { // Shifts for previous row 'i-1'
                // Check if the condition grid[i-1][j] < grid[i][j] holds for all columns 'j'
                // given row 'i-1' shifted 'prev_s' times and row 'i' shifted 's' times.
                int is_valid_combination = 1;
                for (int j = 0; j < n; j++) { // Column index
                    // Calculate the values in the current column 'j' after shifts
                    // (j - shift_count + n) % n handles negative results from (j - shift_count)
                    int val_prev_row = grid[i - 1][(j - prev_s + n) % n];
                    int val_curr_row = grid[i][(j - s + n) % n];

                    if (val_prev_row >= val_curr_row) {
                        is_valid_combination = 0;
                        break; // Condition violated for this column, this prev_s/s combination is invalid
                    }
                }

                if (is_valid_combination) {
                    // If dp[i-1][prev_s] is INT_MAX, it means that state was unreachable.
                    // Adding 's' to INT_MAX would overflow, so check for it.
                    if (dp[i - 1][prev_s] != INT_MAX) {
                        if (dp[i - 1][prev_s] + s < dp[i][s]) {
                            dp[i][s] = dp[i - 1][prev_s] + s;
                        }
                    }
                }
            }
        }
    }

    // The final answer is the minimum value in the last row of the DP table
    int min_total_operations = INT_MAX;
    for (int s = 0; s < n; s++) {
        if (dp[m - 1][s] < min_total_operations) {
            min_total_operations = dp[m - 1][s];
        }
    }

    // Free allocated memory
    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return min_total_operations;
}