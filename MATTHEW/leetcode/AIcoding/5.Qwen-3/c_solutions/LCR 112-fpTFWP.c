#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int** matrix;
int rows;
int cols;
int** dp;

int dfs(int i, int j) {
    if (dp[i][j] != 0) return dp[i][j];
    int maxPath = 1;
    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    for (int k = 0; k < 4; k++) {
        int ni = i + directions[k][0];
        int nj = j + directions[k][1];
        if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && matrix[ni][nj] > matrix[i][j]) {
            int path = 1 + dfs(ni, nj);
            if (path > maxPath) maxPath = path;
        }
    }
    dp[i][j] = maxPath;
    return maxPath;
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    rows = matrixSize;
    cols = matrixColSize[0];
    matrix = matrix;
    dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dp[i][j] = 0;
        }
    }
    int result = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result = fmax(result, dfs(i, j));
        }
    }
    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);
    return result;
}