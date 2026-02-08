int minCut(char * s, int k) {
    int n = strlen(s);
    int dp[n + 1], pal[n][n];

    for (int i = 0; i <= n; i++) {
        dp[i] = i - 1;
    }

    for (int len = 1; len <= n; len++) {
        for (int i = 0; i + len - 1 < n; i++) {
            int j = i + len - 1;
            if (s[i] == s[j] && (len < 3 || pal[i + 1][j - 1])) {
                pal[i][j] = 1;
            }
        }
    }

    for (int cuts = 1; cuts <= k; cuts++) {
        int new_dp[n + 1];
        for (int i = 0; i <= n; i++) {
            new_dp[i] = INT_MAX;
        }

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (pal[i][j]) {
                    new_dp[j + 1] = fmin(new_dp[j + 1], dp[i] + 1);
                }
            }
        }
        memcpy(dp, new_dp, sizeof(dp));
    }

    return dp[n];
}