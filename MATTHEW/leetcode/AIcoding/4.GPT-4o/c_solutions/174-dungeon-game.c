int calculateMinimumHP(int** dungeon, int dungeonSize, int* dungeonColSize) {
    int rows = dungeonSize;
    int cols = dungeonColSize[0];
    int dp[rows + 1][cols + 1];

    for (int i = 0; i <= rows; i++) {
        for (int j = 0; j <= cols; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[rows][cols - 1] = 1;
    dp[rows - 1][cols] = 1;

    for (int i = rows - 1; i >= 0; i--) {
        for (int j = cols - 1; j >= 0; j--) {
            int minHP = fmax(1, fmin(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j]);
            dp[i][j] = minHP;
        }
    }

    return dp[0][0];
}