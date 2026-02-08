int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int safestPath(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    dp[0][0] = grid[0][0];
    for (int i = 1; i < rows; i++) {
        dp[i][0] = max(dp[i-1][0], grid[i][0]);
    }
    for (int j = 1; j < cols; j++) {
        dp[0][j] = max(dp[0][j-1], grid[0][j]);
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 1; j < cols; j++) {
            dp[i][j] = min(max(dp[i-1][j], grid[i][j]), max(dp[i][j-1], grid[i][j]));
        }
    }

    int result = dp[rows-1][cols-1];

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}