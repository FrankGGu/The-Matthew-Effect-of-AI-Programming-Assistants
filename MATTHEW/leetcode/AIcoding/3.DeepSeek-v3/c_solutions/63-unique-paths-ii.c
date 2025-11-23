int uniquePathsWithObstacles(int** obstacleGrid, int obstacleGridSize, int* obstacleGridColSize) {
    int m = obstacleGridSize;
    int n = obstacleGridColSize[0];

    if (obstacleGrid[0][0] == 1) return 0;

    long** dp = (long**)malloc(m * sizeof(long*));
    for (int i = 0; i < m; i++) {
        dp[i] = (long*)malloc(n * sizeof(long));
    }

    dp[0][0] = 1;

    for (int i = 1; i < m; i++) {
        dp[i][0] = (obstacleGrid[i][0] == 0 && dp[i-1][0] == 1) ? 1 : 0;
    }

    for (int j = 1; j < n; j++) {
        dp[0][j] = (obstacleGrid[0][j] == 0 && dp[0][j-1] == 1) ? 1 : 0;
    }

    for (int i = 1; i < m; i++) {
        for (int j = 1; j < n; j++) {
            if (obstacleGrid[i][j] == 1) {
                dp[i][j] = 0;
            } else {
                dp[i][j] = dp[i-1][j] + dp[i][j-1];
            }
        }
    }

    long result = dp[m-1][n-1];

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return (int)result;
}