#include <stdlib.h> // For malloc, calloc
#include <string.h> // For memset (not strictly needed with calloc)

int pathsWithSumDivisibleByK(int** grid, int gridRowSize, int* gridColSizes, int k) {
    int MOD = 1000000007;
    int gridColSize = gridColSizes[0]; // Assuming a rectangular matrix

    // dp[i][j][rem] stores the number of paths from (0,0) to (i,j)
    // such that the sum of elements along the path has remainder 'rem' when divided by 'k'.
    // Using calloc to initialize all elements to 0.
    int*** dp = (int***)calloc(gridRowSize, sizeof(int**));
    for (int i = 0; i < gridRowSize; ++i) {
        dp[i] = (int**)calloc(gridColSize, sizeof(int*));
        for (int j = 0; j < gridColSize; ++j) {
            dp[i][j] = (int*)calloc(k, sizeof(int));
        }
    }

    // Base case: starting cell (0,0)
    // The sum is grid[0][0], so the remainder is grid[0][0] % k.
    // grid values are non-negative, so grid[0][0] % k is always non-negative.
    dp[0][0][grid[0][0] % k] = 1;

    for (int i = 0; i < gridRowSize; ++i) {
        for (int j = 0; j < gridColSize; ++j) {
            // Skip the base case as it's already initialized
            if (i == 0 && j == 0) {
                continue;
            }

            int current_val = grid[i][j];

            // Paths coming from the cell above (i-1, j)
            if (i > 0) {
                for (int prev_rem = 0; prev_rem < k; ++prev_rem) {
                    if (dp[i-1][j][prev_rem] > 0) { // Only consider paths that actually exist
                        int new_rem = (prev_rem + current_val) % k;
                        dp[i][j][new_rem] = (dp[i][j][new_rem] + dp[i-1][j][prev_rem]) % MOD;
                    }
                }
            }

            // Paths coming from the cell to the left (i, j-1)
            if (j > 0) {
                for (int prev_rem = 0; prev_rem < k; ++prev_rem) {
                    if (dp[i][j-1][prev_rem] > 0) { // Only consider paths that actually exist
                        int new_rem = (prev_rem + current_val) % k;
                        dp[i][j][new_rem] = (dp[i][j][new_rem] + dp[i][j-1][prev_rem]) % MOD;
                    }
                }
            }
        }
    }

    int result = dp[gridRowSize - 1][gridColSize - 1][0];

    // Free allocated memory
    for (int i = 0; i < gridRowSize; ++i) {
        for (int j = 0; j < gridColSize; ++j) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return result;
}