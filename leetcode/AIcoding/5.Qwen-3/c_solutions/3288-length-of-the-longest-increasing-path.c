#include <stdio.h>
#include <stdlib.h>

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize[0] == 0) return 0;

    int rows = matrixSize;
    int cols = matrixColSize[0];
    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dp[i][j] = -1;
        }
    }

    int maxLen = 0;

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    int dfs(int i, int j) {
        if (dp[i][j] != -1) return dp[i][j];

        int maxPath = 1;
        for (int d = 0; d < 4; d++) {
            int ni = i + directions[d][0];
            int nj = j + directions[d][1];
            if (ni >= 0 && ni < rows && nj >= 0 && nj < cols && matrix[ni][nj] > matrix[i][j]) {
                int path = 1 + dfs(ni, nj);
                maxPath = (path > maxPath) ? path : maxPath;
            }
        }

        dp[i][j] = maxPath;
        return maxPath;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int len = dfs(i, j);
            maxLen = (len > maxLen) ? len : maxLen;
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxLen;
}