int findMaxForm(char** strs, int strsSize, int m, int n) {
    int dp[m + 1][n + 1];
    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int k = 0; k < strsSize; k++) {
        int zeros = 0, ones = 0;
        char* s = strs[k];
        for (int i = 0; s[i] != '\0'; i++) {
            if (s[i] == '0') zeros++;
            else ones++;
        }

        for (int i = m; i >= zeros; i--) {
            for (int j = n; j >= ones; j--) {
                if (dp[i][j] < dp[i - zeros][j - ones] + 1) {
                    dp[i][j] = dp[i - zeros][j - ones] + 1;
                }
            }
        }
    }

    return dp[m][n];
}