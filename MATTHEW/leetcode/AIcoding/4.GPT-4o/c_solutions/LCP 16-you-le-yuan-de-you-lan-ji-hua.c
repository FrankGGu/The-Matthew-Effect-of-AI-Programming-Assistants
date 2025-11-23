int maxFun(int n, int* rides, int ridesSize) {
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < ridesSize; i++) {
        for (int j = n; j >= rides[i]; j--) {
            dp[j] = dp[j] > dp[j - rides[i]] + rides[i] ? dp[j] : dp[j - rides[i]] + rides[i];
        }
    }

    return dp[n];
}