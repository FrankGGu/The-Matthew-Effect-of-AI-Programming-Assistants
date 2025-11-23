int numPermsDISequence(char * S) {
    int n = strlen(S);
    int dp[n + 1][n + 1];
    int mod = 1000000007;

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= i; j++) {
            if (S[i - 1] == 'I') {
                for (int k = j; k < i; k++) {
                    dp[i][k + 1] = (dp[i][k + 1] + dp[i - 1][k]) % mod;
                }
            } else {
                for (int k = 0; k < j; k++) {
                    dp[i][k] = (dp[i][k] + dp[i - 1][k]) % mod;
                }
            }
        }
    }

    int result = 0;
    for (int j = 0; j <= n; j++) {
        result = (result + dp[n][j]) % mod;
    }

    return result;
}