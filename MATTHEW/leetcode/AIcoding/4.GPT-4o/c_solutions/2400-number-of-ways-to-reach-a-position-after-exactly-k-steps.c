int numWays(int steps, int arrLen) {
    int mod = 1e9 + 7;
    int maxPos = fmin(arrLen - 1, steps);
    int dp[maxPos + 1][steps + 1];

    for (int i = 0; i <= maxPos; i++) {
        for (int j = 0; j <= steps; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int j = 1; j <= steps; j++) {
        for (int i = 0; i <= maxPos; i++) {
            dp[i][j] = dp[i][j - 1];
            if (i > 0) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % mod;
            }
            if (i < maxPos) {
                dp[i][j] = (dp[i][j] + dp[i + 1][j - 1]) % mod;
            }
        }
    }

    return dp[0][steps];
}