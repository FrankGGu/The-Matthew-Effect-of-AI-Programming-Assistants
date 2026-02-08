int maxValueOfCoins(int** piles, int pilesSize, int* pilesColSize, int k) {
    int dp[pilesSize + 1][k + 1];
    for (int i = 0; i <= pilesSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = 1; i <= pilesSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            int sum = 0;
            for (int l = 1; l <= pilesColSize[i - 1] && l <= j; l++) {
                sum += piles[i - 1][l - 1];
                if (dp[i][j] < dp[i - 1][j - l] + sum) {
                    dp[i][j] = dp[i - 1][j - l] + sum;
                }
            }
        }
    }

    return dp[pilesSize][k];
}