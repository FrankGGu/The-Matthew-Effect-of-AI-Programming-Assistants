int maxScore(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int dp[rows][cols];

    for (int i = 0; i < cols; i++) {
        dp[0][i] = grid[0][i];
    }

    for (int i = 1; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            dp[i][j] = grid[i][j];
            int maxPrev = 0;
            for (int k = 0; k < cols; k++) {
                maxPrev = fmax(maxPrev, dp[i - 1][k]);
            }
            dp[i][j] += maxPrev;
        }
    }

    int maxScore = 0;
    for (int i = 0; i < cols; i++) {
        maxScore = fmax(maxScore, dp[rows - 1][i]);
    }

    return maxScore;
}