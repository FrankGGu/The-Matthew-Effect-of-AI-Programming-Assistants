#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int max(int a, int b, int c) {
    return max(max(a, b), c);
}

int cherryPickupII(int** grid, int rows, int* cols) {
    int n = rows;
    int m = *cols;
    int dp[2][m];
    for (int j = 0; j < m; j++) {
        dp[0][j] = grid[0][j];
    }
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int maxCherries = 0;
            for (int dj = -1; dj <= 1; dj++) {
                int prevJ = j + dj;
                if (prevJ >= 0 && prevJ < m) {
                    maxCherries = max(maxCherries, dp[(i - 1) % 2][prevJ]);
                }
            }
            dp[i % 2][j] = maxCherries + grid[i][j];
        }
    }
    int result = 0;
    for (int j = 0; j < m; j++) {
        result = max(result, dp[(n - 1) % 2][j]);
    }
    return result;
}