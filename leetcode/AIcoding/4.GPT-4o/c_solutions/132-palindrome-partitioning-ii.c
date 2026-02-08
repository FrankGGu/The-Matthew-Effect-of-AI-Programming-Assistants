int minCut(char * s) {
    int n = strlen(s);
    int dp[n + 1];
    bool pal[n][n];

    for (int i = 0; i <= n; i++) {
        dp[i] = n - 1 - i;
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = i; j < n; j++) {
            if (s[i] == s[j] && (j - i < 2 || pal[i + 1][j - 1])) {
                pal[i][j] = true;
                dp[i] = j == n - 1 ? 0 : fmin(dp[i], 1 + dp[j + 1]);
            }
        }
    }

    return dp[0];
}