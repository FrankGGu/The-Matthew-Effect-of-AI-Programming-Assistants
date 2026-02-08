int numDistinct(char * s, char * t) {
    int m = strlen(s), n = strlen(t);
    int dp[n + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 1; i <= m; i++) {
        for (int j = n; j > 0; j--) {
            if (s[i - 1] == t[j - 1]) {
                dp[j] += dp[j - 1];
            }
        }
    }
    return dp[n];
}