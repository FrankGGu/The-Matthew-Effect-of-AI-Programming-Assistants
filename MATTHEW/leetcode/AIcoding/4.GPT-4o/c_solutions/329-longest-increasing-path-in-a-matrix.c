int dfs(int** matrix, int matrixSize, int* matrixColSize, int x, int y, int** dp) {
    if (dp[x][y] != -1) return dp[x][y];
    int dirs[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    dp[x][y] = 1;
    for (int i = 0; i < 4; i++) {
        int newX = x + dirs[i][0];
        int newY = y + dirs[i][1];
        if (newX >= 0 && newX < matrixSize && newY >= 0 && newY < *matrixColSize && matrix[newX][newY] > matrix[x][y]) {
            dp[x][y] = fmax(dp[x][y], 1 + dfs(matrix, matrixSize, matrixColSize, newX, newY, dp));
        }
    }
    return dp[x][y];
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) return 0;
    int** dp = (int**)malloc(matrixSize * sizeof(int*));
    for (int i = 0; i < matrixSize; i++) {
        dp[i] = (int*)malloc(*matrixColSize * sizeof(int));
        for (int j = 0; j < *matrixColSize; j++) {
            dp[i][j] = -1;
        }
    }
    int maxPath = 0;
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < *matrixColSize; j++) {
            maxPath = fmax(maxPath, dfs(matrix, matrixSize, matrixColSize, i, j, dp));
        }
    }
    for (int i = 0; i < matrixSize; i++) {
        free(dp[i]);
    }
    free(dp);
    return maxPath;
}