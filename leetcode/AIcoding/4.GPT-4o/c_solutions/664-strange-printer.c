int strangePrinter(char * s) {
    int n = strlen(s);
    int dp[n][n];

    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            int j = i + length - 1;
            dp[i][j] = dp[i][j - 1] + 1;
            if (s[j] == s[i]) {
                dp[i][j] = dp[i][j] - 1;
            }
            for (int k = i; k < j; k++) {
                if (s[k] == s[j]) {
                    dp[i][j] = fmin(dp[i][j], dp[i][k] + dp[k + 1][j - 1]);
                }
            }
        }
    }

    return dp[0][n - 1];
}