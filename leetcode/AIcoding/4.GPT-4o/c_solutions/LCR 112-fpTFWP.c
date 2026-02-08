int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) return 0;

    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int** dp = (int**)malloc(matrixSize * sizeof(int*));
    for (int i = 0; i < matrixSize; i++) {
        dp[i] = (int*)calloc(*matrixColSize, sizeof(int));
    }

    int dfs(int x, int y) {
        if (dp[x][y]) return dp[x][y];
        dp[x][y] = 1;
        for (int i = 0; i < 4; i++) {
            int newX = x + directions[i][0];
            int newY = y + directions[i][1];
            if (newX >= 0 && newX < matrixSize && newY >= 0 && newY < *matrixColSize && matrix[newX][newY] > matrix[x][y]) {
                dp[x][y] = fmax(dp[x][y], 1 + dfs(newX, newY));
            }
        }
        return dp[x][y];
    }

    int maxPath = 0;
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < *matrixColSize; j++) {
            maxPath = fmax(maxPath, dfs(i, j));
        }
    }

    for (int i = 0; i < matrixSize; i++) {
        free(dp[i]);
    }
    free(dp);

    return maxPath;
}