int minPathCost(int** grid, int gridSize, int* gridColSize, int** moveCost, int moveCostSize, int* moveCostColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int** dp = (int**)malloc(rows * sizeof(int*));

    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int j = 0; j < cols; j++) {
        dp[0][j] = grid[0][j];
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            dp[i][j] = INT_MAX;
            for (int k = 0; k < cols; k++) {
                dp[i][j] = fmin(dp[i][j], dp[i - 1][k] + grid[i][j] + moveCost[k][j]);
            }
        }
    }

    int minCost = INT_MAX;
    for (int j = 0; j < cols; j++) {
        minCost = fmin(minCost, dp[rows - 1][j]);
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return minCost;
}