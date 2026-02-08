int minIncrements(int n, int* cost, int target) {
    int dp[target + 1];
    memset(dp, 0x3f, sizeof(dp));
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        for (int j = target; j >= cost[i]; j--) {
            dp[j] = fmin(dp[j], dp[j - cost[i]] + cost[i]);
        }
    }

    return dp[target] == 0x3f3f3f3f ? -1 : dp[target];
}