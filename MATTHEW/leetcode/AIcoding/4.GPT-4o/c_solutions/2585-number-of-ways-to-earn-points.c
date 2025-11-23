int waysToEarnPoints(int target, int[][] points) {
    int mod = 1000000007;
    int n = sizeof(points) / sizeof(points[0]);
    int dp[target + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int i = 0; i < n; i++) {
        for (int j = points[i][0]; j <= target; j++) {
            dp[j] = (dp[j] + dp[j - points[i][0]]) % mod;
        }
    }
    return dp[target];
}