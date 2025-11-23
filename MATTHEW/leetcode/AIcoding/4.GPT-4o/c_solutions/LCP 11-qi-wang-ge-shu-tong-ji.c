double getExpectation(int n, double x) {
    double dp[n + 1];
    dp[0] = 1.0;
    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] * (1.0 - x) + (i > 1 ? dp[i - 2] * x : 0);
    }
    return dp[n];
}