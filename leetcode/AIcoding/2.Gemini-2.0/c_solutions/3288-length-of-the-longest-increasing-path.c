#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0) return 0;

    int rows = matrixSize;
    int cols = matrixColSize[0];

    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dp[i][j] = 0;
        }
    }

    int maxLen = 0;

    int dfs(int i, int j, int prev) {
        if (i < 0 || i >= rows || j < 0 || j >= cols || matrix[i][j] <= prev) {
            return 0;
        }

        if (dp[i][j] != 0) {
            return dp[i][j];
        }

        int len1 = dfs(i + 1, j, matrix[i][j]);
        int len2 = dfs(i - 1, j, matrix[i][j]);
        int len3 = dfs(i, j + 1, matrix[i][j]);
        int len4 = dfs(i, j - 1, matrix[i][j]);

        dp[i][j] = 1 + (len1 > len2 ? (len1 > len3 ? (len1 > len4 ? len1 : len4) : (len3 > len4 ? len3 : len4)) : (len2 > len3 ? (len2 > len4 ? len2 : len4) : (len3 > len4 ? len3 : len4)));
        return dp[i][j];
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            maxLen = (maxLen > dfs(i, j, -1)) ? maxLen : dfs(i, j, -1);
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxLen;
}