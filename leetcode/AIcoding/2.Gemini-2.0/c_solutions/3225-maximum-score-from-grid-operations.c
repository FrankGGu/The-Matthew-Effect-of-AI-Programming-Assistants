#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int solve(int** grid, int row, int col, int m, int n, int** dp) {
    if (row == m - 1 && col == n - 1) {
        return grid[row][col];
    }

    if (dp[row][col] != -1) {
        return dp[row][col];
    }

    int ans = -1;

    if (row + 1 < m) {
        ans = max(ans, solve(grid, row + 1, col, m, n, dp));
    }

    if (col + 1 < n) {
        ans = max(ans, solve(grid, row, col + 1, m, n, dp));
    }

    dp[row][col] = (ans == -1) ? -1 : grid[row][col] + ans;
    return dp[row][col];
}

int maxScore(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dp[i][j] = -1;
        }
    }

    int result = solve(grid, 0, 0, m, n, dp);

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}