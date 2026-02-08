int numSquares(int n) {
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = i; // Maximum squares needed is i (1^2 + 1^2 + ... + 1^2)
    }
    for (int i = 2; i <= n; i++) {
        for (int j = 1; j * j <= i; j++) {
            dp[i] = fmin(dp[i], dp[i - j * j] + 1);
        }
    }
    return dp[n];
}