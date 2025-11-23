#include <stdio.h>
#include <stdlib.h>

int maxScore(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];
    int i, j;
    int** dp = (int**)malloc(m * sizeof(int*));
    for (i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }
    dp[0][0] = grid[0][0];
    for (i = 1; i < m; i++) {
        dp[i][0] = dp[i - 1][0] + grid[i][0];
    }
    for (j = 1; j < n; j++) {
        dp[0][j] = dp[0][j - 1] + grid[0][j];
    }
    for (i = 1; i < m; i++) {
        for (j = 1; j < n; j++) {
            dp[i][j] = grid[i][j] + (dp[i - 1][j] > dp[i][j - 1] ? dp[i - 1][j] : dp[i][j - 1]);
        }
    }
    int result = dp[m - 1][n - 1];
    for (i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}