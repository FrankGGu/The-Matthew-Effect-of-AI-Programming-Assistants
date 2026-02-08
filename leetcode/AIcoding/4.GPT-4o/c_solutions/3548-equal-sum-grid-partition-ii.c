bool canPartitionGrid(int** grid, int gridSize, int* gridColSize) {
    int totalSum = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            totalSum += grid[i][j];
        }
    }
    if (totalSum % 2 != 0) return false;
    int target = totalSum / 2;
    int n = gridSize * gridColSize[0];
    bool dp[target + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = true;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            for (int k = target; k >= grid[i][j]; k--) {
                dp[k] = dp[k] || dp[k - grid[i][j]];
            }
        }
    }
    return dp[target];
}