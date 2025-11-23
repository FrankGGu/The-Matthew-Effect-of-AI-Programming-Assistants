bool checkPartitioning(char* s) {
    int n = strlen(s);
    bool dp[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = false;
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = i; j < n; j++) {
            if (s[i] == s[j]) {
                if (j - i <= 2) {
                    dp[i][j] = true;
                } else {
                    dp[i][j] = dp[i + 1][j - 1];
                }
            }
        }
    }

    for (int i = 1; i < n - 1; i++) {
        for (int j = i; j < n - 1; j++) {
            if (dp[0][i - 1] && dp[i][j] && dp[j + 1][n - 1]) {
                return true;
            }
        }
    }

    return false;
}