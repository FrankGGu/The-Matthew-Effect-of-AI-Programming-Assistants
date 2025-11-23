int minimumScore(char *s, char *t) {
    int m = strlen(s), n = strlen(t);
    int dp[n + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < m; ++i) {
        for (int j = n - 1; j >= 0; --j) {
            if (s[i] == t[j]) {
                dp[j + 1] = dp[j] + 1;
            }
        }
    }

    int max_len = dp[n];
    int min_score = n - max_len;

    for (int i = 0; i < n; ++i) {
        dp[i + 1] = max(dp[i + 1], dp[i]);
    }

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            if (s[i] == t[j]) {
                min_score = fmin(min_score, n - (dp[j + 1] + 1));
            }
        }
    }

    return min_score;
}