#include <stdio.h>
#include <stdlib.h>

int** dp;
int rows, cols, k;

int dfs(int** grid, int i, int j, int sum) {
    if (i == rows || j == cols) return 0;
    if (i == rows - 1 && j == cols - 1) {
        return (sum + grid[i][j]) % k == 0 ? 1 : 0;
    }
    if (dp[i][j] != -1) return dp[i][j];

    int mod = (sum + grid[i][j]) % k;
    int down = dfs(grid, i + 1, j, mod);
    int right = dfs(grid, i, j + 1, mod);

    dp[i][j] = (down + right) % 1000000007;
    return dp[i][j];
}

int pathSum(int** grid, int gridSize, int* gridColSize, int k) {
    rows = gridSize;
    cols = gridColSize[0];
    k = k;

    dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dp[i][j] = -1;
        }
    }

    int result = dfs(grid, 0, 0, 0);

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}