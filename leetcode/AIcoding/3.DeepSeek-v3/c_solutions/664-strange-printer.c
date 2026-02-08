int strangePrinter(char* s) {
    int n = strlen(s);
    if (n == 0) return 0;

    int dp[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = i; j < n; j++) {
            if (i == j) {
                dp[i][j] = 1;
            } else {
                dp[i][j] = dp[i + 1][j] + 1;
                for (int k = i + 1; k <= j; k++) {
                    if (s[i] == s[k]) {
                        int left = (i + 1 <= k - 1) ? dp[i + 1][k - 1] : 0;
                        int right = dp[k][j];
                        if (left + right < dp[i][j]) {
                            dp[i][j] = left + right;
                        }
                    }
                }
            }
        }
    }

    return dp[0][n - 1];
}