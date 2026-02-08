#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numIncreasingPath(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int mod = 1000000007;

    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dp[i][j] = 0;
        }
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    int dfs(int i, int j) {
        if (dp[i][j] != 0) {
            return dp[i][j];
        }

        dp[i][j] = 1;
        for (int k = 0; k < 4; k++) {
            int ni = i + dx[k];
            int nj = j + dy[k];

            if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && grid[ni][nj] > grid[i][j]) {
                dp[i][j] = (dp[i][j] + dfs(ni, nj)) % mod;
            }
        }
        return dp[i][j];
    }

    int result = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result = (result + dfs(i, j)) % mod;
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}