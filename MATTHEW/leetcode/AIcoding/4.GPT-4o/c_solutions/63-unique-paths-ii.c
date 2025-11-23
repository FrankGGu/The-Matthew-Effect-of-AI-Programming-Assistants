int uniquePathsWithObstacles(int** obstacleGrid, int obstacleGridSize, int* obstacleGridColSize) {
    if (obstacleGrid[0][0] == 1 || obstacleGrid[obstacleGridSize - 1][obstacleGridColSize[0] - 1] == 1) {
        return 0;
    }

    int rows = obstacleGridSize;
    int cols = obstacleGridColSize[0];
    int dp[rows][cols];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (obstacleGrid[i][j] == 1) {
                dp[i][j] = 0;
            } else if (i == 0 && j == 0) {
                dp[i][j] = 1;
            } else {
                dp[i][j] = (i > 0 ? dp[i - 1][j] : 0) + (j > 0 ? dp[i][j - 1] : 0);
            }
        }
    }

    return dp[rows - 1][cols - 1];
}