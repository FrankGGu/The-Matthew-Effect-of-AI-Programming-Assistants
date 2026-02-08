bool isScramble(char* s1, char* s2) {
    int n = strlen(s1);
    if (n != strlen(s2)) return false;

    bool dp[n][n][n+1];
    memset(dp, false, sizeof(dp));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j][1] = (s1[i] == s2[j]);
        }
    }

    for (int length = 2; length <= n; length++) {
        for (int i = 0; i <= n - length; i++) {
            for (int j = 0; j <= n - length; j++) {
                for (int k = 1; k < length; k++) {
                    if ((dp[i][j][k] && dp[i+k][j+k][length-k]) ||
                        (dp[i][j+length-k][k] && dp[i+k][j][length-k])) {
                        dp[i][j][length] = true;
                        break;
                    }
                }
            }
        }
    }

    return dp[0][0][n];
}