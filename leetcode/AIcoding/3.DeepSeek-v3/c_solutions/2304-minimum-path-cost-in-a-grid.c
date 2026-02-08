int minPathCost(int** grid, int gridSize, int* gridColSize, int** moveCost, int moveCostSize, int* moveCostColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    for (int j = 0; j < n; j++) {
        dp[0][j] = grid[0][j];
    }

    for (int i = 1; i < m; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = INT_MAX;
            for (int k = 0; k < n; k++) {
                int prevVal = grid[i-1][k];
                int cost = dp[i-1][k] + moveCost[prevVal][j] + grid[i][j];
                if (cost < dp[i][j]) {
                    dp[i][j] = cost;
                }
            }
        }
    }

    int minCost = INT_MAX;
    for (int j = 0; j < n; j++) {
        if (dp[m-1][j] < minCost) {
            minCost = dp[m-1][j];
        }
    }

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return minCost;
}