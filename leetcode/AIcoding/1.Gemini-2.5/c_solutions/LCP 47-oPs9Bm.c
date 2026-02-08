#include <stdlib.h> // Required for general utilities, though not strictly for this specific VLA solution.

static inline int min(int a, int b) {
    return a < b ? a : b;
}

int securityCheck(int** security, int securitySize, int* securityColSize) {
    int n = securitySize;
    int m = securityColSize[0];

    // Create a 2D DP table using Variable Length Array (VLA).
    // This is a common and accepted practice on LeetCode for C solutions
    // when dimensions are known at runtime and within reasonable limits.
    int dp[n][m];

    // Initialize the starting cell
    dp[0][0] = security[0][0];

    // Fill the first row: can only come from the left
    for (int j = 1; j < m; j++) {
        dp[0][j] = dp[0][j - 1] + security[0][j];
    }

    // Fill the first column: can only come from above
    for (int i = 1; i < n; i++) {
        dp[i][0] = dp[i - 1][0] + security[i][0];
    }

    // Fill the rest of the DP table
    // For each cell (i, j), the minimum time to reach it is
    // security[i][j] plus the minimum of the time to reach (i-1, j) (from above)
    // or (i, j-1) (from left).
    for (int i = 1; i < n; i++) {
        for (int j = 1; j < m; j++) {
            dp[i][j] = security[i][j] + min(dp[i - 1][j], dp[i][j - 1]);
        }
    }

    // The result is the minimum time to reach the bottom-right cell
    return dp[n - 1][m - 1];
}