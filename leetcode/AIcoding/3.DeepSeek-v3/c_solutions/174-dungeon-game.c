int calculateMinimumHP(int** dungeon, int dungeonSize, int* dungeonColSize) {
    int m = dungeonSize;
    int n = dungeonColSize[0];

    int** dp = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dp[i] = (int*)malloc(n * sizeof(int));
    }

    dp[m-1][n-1] = dungeon[m-1][n-1] > 0 ? 1 : 1 - dungeon[m-1][n-1];

    for (int i = m-2; i >= 0; i--) {
        int need = dp[i+1][n-1] - dungeon[i][n-1];
        dp[i][n-1] = need <= 0 ? 1 : need;
    }

    for (int j = n-2; j >= 0; j--) {
        int need = dp[m-1][j+1] - dungeon[m-1][j];
        dp[m-1][j] = need <= 0 ? 1 : need;
    }

    for (int i = m-2; i >= 0; i--) {
        for (int j = n-2; j >= 0; j--) {
            int need = fmin(dp[i+1][j], dp[i][j+1]) - dungeon[i][j];
            dp[i][j] = need <= 0 ? 1 : need;
        }
    }

    int result = dp[0][0];

    for (int i = 0; i < m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}