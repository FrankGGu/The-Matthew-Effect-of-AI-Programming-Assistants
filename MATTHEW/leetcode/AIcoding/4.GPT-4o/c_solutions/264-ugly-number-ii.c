int nthUglyNumber(int n) {
    int dp[n];
    dp[0] = 1;
    int idx2 = 0, idx3 = 0, idx5 = 0;
    for (int i = 1; i < n; i++) {
        dp[i] = fmin(fmin(dp[idx2] * 2, dp[idx3] * 3), dp[idx5] * 5);
        if (dp[i] == dp[idx2] * 2) idx2++;
        if (dp[i] == dp[idx3] * 3) idx3++;
        if (dp[i] == dp[idx5] * 5) idx5++;
    }
    return dp[n - 1];
}