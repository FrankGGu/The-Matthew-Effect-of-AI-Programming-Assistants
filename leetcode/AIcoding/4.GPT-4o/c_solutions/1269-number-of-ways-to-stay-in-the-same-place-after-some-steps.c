int numWays(int steps, int arrLen) {
    int maxPos = fmin(arrLen - 1, steps);
    int dp[maxPos + 1][steps + 1];
    memset(dp, 0, sizeof(dp));
    dp[0][0] = 1;

    for (int s = 1; s <= steps; s++) {
        for (int pos = 0; pos <= maxPos; pos++) {
            dp[pos][s] = dp[pos][s - 1];
            if (pos > 0) dp[pos][s] = (dp[pos][s] + dp[pos - 1][s - 1]) % 1000000007;
            if (pos < maxPos) dp[pos][s] = (dp[pos][s] + dp[pos + 1][s - 1]) % 1000000007;
        }
    }

    return dp[0][steps];
}