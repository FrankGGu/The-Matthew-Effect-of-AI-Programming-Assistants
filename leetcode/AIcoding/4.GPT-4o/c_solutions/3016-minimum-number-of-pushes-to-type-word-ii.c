int minPushes(char *s, char *t) {
    int n = strlen(s), m = strlen(t);
    int dp[m + 1];
    memset(dp, 0, sizeof(dp));

    for (int j = 1; j <= m; j++) {
        dp[j] = j;
    }

    for (int i = 1; i <= n; i++) {
        int prev = dp[0];
        dp[0] = i;
        for (int j = 1; j <= m; j++) {
            int temp = dp[j];
            if (s[i - 1] == t[j - 1]) {
                dp[j] = prev;
            } else {
                dp[j] = 1 + fmin(prev, fmin(dp[j - 1], dp[j]));
            }
            prev = temp;
        }
    }

    return dp[m];
}