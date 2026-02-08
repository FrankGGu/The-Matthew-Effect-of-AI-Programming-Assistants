#include <stdlib.h> // For malloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int calculateMinimumHP(int** dungeon, int dungeonSize, int* dungeonColSize) {
    int m = dungeonSize;
    int n = dungeonColSize[0]; // All rows have the same number of columns

    // Create a 2D DP array to store the minimum health required
    // dp[i][j] represents the minimum health the knight needs upon entering cell (i, j)
    // to successfully reach the princess.
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; ++i) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    // Fill the DP table from bottom-right to top-left
    for (int i = m - 1; i >= 0; --i) {
        for (int j = n - 1; j >= 0; --j) {
            if (i == m - 1 && j == n - 1) {
                // Base case: bottom-right cell (princess's location)
                // The knight must have at least 1 health when leaving this cell.
                // So, health needed upon entering = max(1, 1 - dungeon[i][j])
                dp[i][j] = max(1, 1 - dungeon[i][j]);
            } else if (i == m - 1) {
                // Last row: can only move right
                // Health needed upon entering = max(1, health needed for next cell - current cell's value)
                dp[i][j] = max(1, dp[i][j+1] - dungeon[i][j]);
            } else if (j == n - 1) {
                // Last column: can only move down
                // Health needed upon entering = max(1, health needed for next cell - current cell's value)
                dp[i][j] = max(1, dp[i+1][j] - dungeon[i][j]);
            } else {
                // General case: can move right or down
                // Choose the path that requires less health from the next step
                int min_health_needed_from_next_step = min(dp[i+1][j], dp[i][j+1]);
                // Health needed upon entering = max(1, min_health_from_next_step - current cell's value)
                dp[i][j] = max(1, min_health_needed_from_next_step - dungeon[i][j]);
            }
        }
    }

    // The result is the minimum health needed upon entering the starting cell (0, 0)
    int result = dp[0][0];

    // Free allocated memory for the DP table
    for (int i = 0; i < m; ++i) {
        free(dp[i]);
    }
    free(dp);

    return result;
}