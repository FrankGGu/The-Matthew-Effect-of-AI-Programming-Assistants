#include <stdio.h>
#include <stdlib.h>

int** grid;
int rows, cols;
int** dp;

int dfs(int r, int c, int k) {
    if (r < 0 || r >= rows || c < 0 || c >= cols) return 0;
    if (grid[r][c] == 1) return 0;
    if (k == 0) return 1;
    if (dp[r][c] != -1) return dp[r][c];

    dp[r][c] = dfs(r + 1, c, k - 1) ||
               dfs(r - 1, c, k - 1) ||
               dfs(r, c + 1, k - 1) ||
               dfs(r, c - 1, k - 1);

    return dp[r][c];
}

int isSafeWalk(int** grid_, int gridSize, int* gridColSize, int k) {
    rows = gridSize;
    cols = gridColSize[0];
    grid = grid_;
    dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dp[i][j] = -1;
        }
    }

    int result = dfs(0, 0, k);

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}