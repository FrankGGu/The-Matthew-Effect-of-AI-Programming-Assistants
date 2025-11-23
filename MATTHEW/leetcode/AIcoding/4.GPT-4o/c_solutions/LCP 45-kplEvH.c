int numberOfCombinations(char *num) {
    int n = strlen(num);
    long long dp[n + 1][n + 1];
    memset(dp, 0, sizeof(dp));
    dp[0][0] = 1;

    for (int len = 1; len <= n; len++) {
        for (int start = 0; start + len <= n; start++) {
            if (num[start] == '0' && len > 1) continue;
            long long number = 0;
            for (int k = 0; k < len; k++) {
                number = number * 10 + (num[start + k] - '0');
                if (number > INT_MAX) break;
            }
            for (int j = 0; j <= n; j++) {
                if (j == 0 || (j > 0 && number >= j)) {
                    dp[len][j] = (dp[len][j] + dp[len - 1][j - 1]) % 1000000007;
                }
            }
        }
    }

    long long result = 0;
    for (int i = 1; i <= n; i++) {
        result = (result + dp[n][i]) % 1000000007;
    }

    return result;
}