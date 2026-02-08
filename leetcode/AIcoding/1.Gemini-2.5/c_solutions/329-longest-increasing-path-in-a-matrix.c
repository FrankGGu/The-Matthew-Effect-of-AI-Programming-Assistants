#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int dfs(int** matrix, int m, int n, int r, int c, int** dp, int prevVal) {
    if (r < 0 || r >= m || c < 0 || c >= n || matrix[r][c] <= prevVal) {
        return 0;
    }

    if (dp[r][c] != 0) {
        return dp[r][c];
    }

    int currentVal = matrix[r][c];

    int up = dfs(matrix, m, n, r - 1, c, dp, currentVal);
    int down = dfs(matrix, m, n, r + 1, c, dp, currentVal);
    int left = dfs(matrix, m, n, r, c - 1, dp, currentVal);
    int right = dfs(matrix, m, n, r, c + 1, dp, currentVal);

    dp[r][c] = 1 + max(max(up, down), max(left, right));

    return dp[r][c];
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        return 0;
    }

    int m = matrixSize;
    int n = *matrixColSize;

    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)calloc(n, sizeof(int));
    }

    int maxLen = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            maxLen = max(maxLen, dfs(matrix, m, n, i, j, dp, INT_MIN));
        }
    }

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxLen;
}