int maxScore(int* a, int* b, int n) {
    long long dp[5][1001] = {0};
    for (int i = 0; i < n; i++) {
        for (int j = 4; j >= 1; j--) {
            dp[j][i] = (i > 0 ? dp[j][i-1] : LLONG_MIN);
            if (j == 1) {
                if (i >= j-1) {
                    long long val = (long long)a[i] * b[i];
                    dp[j][i] = (dp[j][i] > val ? dp[j][i] : val);
                }
            } else {
                if (i >= j-1 && dp[j-1][i-1] != LLONG_MIN) {
                    long long val = dp[j-1][i-1] + (long long)a[i] * b[i];
                    dp[j][i] = (dp[j][i] > val ? dp[j][i] : val);
                }
            }
        }
    }
    return dp[4][n-1];
}