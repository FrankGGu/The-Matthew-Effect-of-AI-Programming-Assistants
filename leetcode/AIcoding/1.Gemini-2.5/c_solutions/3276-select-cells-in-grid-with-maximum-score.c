#include <stdlib.h> // Required for malloc and free

int max(int a, int b) {
    return a > b ? a : b;
}

int maxScore(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        // If the grid is empty, the maximum score is 0 (or undefined,
        // depending on specific problem constraints, but 0 is common for sums).
        return 0;
    }

    int m = gridSize;
    int n = gridColSize[0];

    // Create a 2D DP table to store the maximum score to reach each cell.
    // dp[i][j] will store the maximum score to reach cell (i, j).
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    // Initialize the starting cell's score.
    dp[0][0] = grid[0][0];

    // Fill the first column of the DP table.
    // To reach any cell in the first column (i, 0), one must come from (i-1, 0).
    for (int i = 1; i < m; i++) {
        dp[i][0] = dp[i-1][0] + grid[i][0];
    }

    // Fill the first row of the DP table.
    // To reach any cell in the first row (0, j), one must come from (0, j-1).
    for (int j = 1; j < n; j++) {
        dp[0][j] = dp[0][j-1] + grid[0][j];
    }

    // Fill the rest of the DP table.
    // To reach cell (i, j), one can either come from (i-1, j) (downward movement)
    // or from (i, j-1) (rightward movement).
    // We choose the path that yields the maximum score.
    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n; j++) {
            dp[i][j] = grid[i][j] + max(dp[i-1][j], dp[i][j-1]);
        }
    }

    // The maximum score to reach the bottom-right cell (m-1, n-1) is our result.
    int result = dp[m-1][n-1];

    // Free the dynamically allocated memory for the DP table.
    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}