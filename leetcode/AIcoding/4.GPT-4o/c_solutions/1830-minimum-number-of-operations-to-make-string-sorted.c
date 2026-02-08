int minOperations(const char *s) {
    int n = strlen(s);
    int dp[n + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + (s[i - 1] != 'a' + (i - 1) % 26);
    }

    return dp[n];
}