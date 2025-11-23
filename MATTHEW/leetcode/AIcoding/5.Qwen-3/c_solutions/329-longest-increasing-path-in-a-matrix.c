#include <stdio.h>
#include <stdlib.h>

int dp[200][200];

int dfs(int** matrix, int m, int n, int i, int j) {
    if (dp[i][j] != 0) return dp[i][j];
    int maxLen = 1;
    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    for (int k = 0; k < 4; k++) {
        int ni = i + directions[k][0];
        int nj = j + directions[k][1];
        if (ni >= 0 && ni < m && nj >= 0 && nj < n && matrix[ni][nj] > matrix[i][j]) {
            int len = 1 + dfs(matrix, m, n, ni, nj);
            if (len > maxLen) maxLen = len;
        }
    }
    dp[i][j] = maxLen;
    return maxLen;
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int result = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            result = fmax(result, dfs(matrix, m, n, i, j));
        }
    }
    return result;
}