int numWays(int steps, int arrLen) {
    int maxPos = steps / 2 + 1;
    if (arrLen < maxPos) maxPos = arrLen;

    long dp[2][maxPos + 2];
    int mod = 1000000007;

    for (int i = 0; i <= maxPos; i++) {
        dp[0][i] = 0;
    }
    dp[0][0] = 1;

    for (int step = 1; step <= steps; step++) {
        int curr = step % 2;
        int prev = (step - 1) % 2;

        for (int pos = 0; pos < maxPos; pos++) {
            dp[curr][pos] = dp[prev][pos];
            if (pos > 0) dp[curr][pos] = (dp[curr][pos] + dp[prev][pos - 1]) % mod;
            if (pos < maxPos - 1) dp[curr][pos] = (dp[curr][pos] + dp[prev][pos + 1]) % mod;
        }
    }

    return dp[steps % 2][0];
}