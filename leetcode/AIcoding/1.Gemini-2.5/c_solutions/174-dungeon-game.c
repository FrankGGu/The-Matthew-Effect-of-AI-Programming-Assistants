#include <stdlib.h> // For malloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int calculateMinimumHP(int** dungeon, int dungeonSize, int* dungeonColSize) {
    int m = dungeonSize;
    int n = dungeonColSize[0];

    // Create a DP table to store the minimum health required upon entering cell (i, j)
    // dp[i][j] represents the minimum health needed *upon entering* cell (i, j)
    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    // Base case: bottom-right cell (princess's location)
    // To survive the last cell dungeon[m-1][n-1] and have at least 1 health after it,
    // the health upon entering must be at least 1 - dungeon[m-1][n-1].
    // Also, health must always be at least 1.
    dp[m - 1][n - 1] = max(1, 1 - dungeon[m - 1][n - 1]);

    // Fill the last row (moving from right to left)
    for (int j = n - 2; j >= 0; j--) {
        // To enter cell (m-1, j), we must have enough health to survive it
        // and then have dp[m-1][j+1] health upon entering (m-1, j+1).
        dp[m - 1][j] = max(1, dp[m - 1][j + 1] - dungeon[m - 1][j]);
    }

    // Fill the last column (moving from bottom to top)
    for (int i = m - 2; i >= 0; i--) {
        // To enter cell (i, n-1), we must have enough health to survive it
        // and then have dp[i+1][n-1] health upon entering (i+1, n-1).
        dp[i][n - 1] = max(1, dp[i + 1][n - 1] - dungeon[i][n - 1]);
    }

    // Fill the rest of the cells (moving from bottom-right to top-left)
    for (int i = m - 2; i >= 0; i--) {
        for (int j = n - 2; j >= 0; j--) {
            // From cell (i, j), the knight can move to (i+1, j) or (i, j+1).
            // We need to choose the path that requires less health upon entering the next cell.
            int min_health_needed_to_proceed = min(dp[i + 1][j], dp[i][j + 1]);

            // To enter cell (i, j), we must have enough health to survive it
            // and then have min_health_needed_to_proceed health upon entering the next cell.
            dp[i][j] = max(1, min_health_needed_to_proceed - dungeon[i][j]);
        }
    }

    // The result is the minimum health needed upon entering the starting cell (0, 0)
    int result = dp[0][0];

    // Free the dynamically allocated memory for the DP table
    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}