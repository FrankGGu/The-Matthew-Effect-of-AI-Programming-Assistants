double soupServings(int N) {
    if (N > 5000) return 1.0;
    double dp[200][200] = {0};
    dp[0][0] = 0.5;
    for (int i = 0; i <= N; i++) {
        for (int j = 0; j <= N; j++) {
            if (i == 0 && j == 0) continue;
            if (i > 0) dp[i][j] += dp[i - 4][j] * 0.25;
            if (j > 0) dp[i][j] += dp[i][j - 4] * 0.25;
            if (i > 0 && j > 0) dp[i][j] += dp[i - 2][j - 2] * 0.25;
            if (i > 0 && j > 0) dp[i][j] += dp[i - 1][j - 3] * 0.25;
            if (i > 0 && j > 0) dp[i][j] += dp[i - 3][j - 1] * 0.25;
        }
    }
    return dp[N][N];
}