int minCost(int** costs, int costsSize, int* costsColSize, int m, int n, int target) {
    int dp[m + 1][target + 1];
    memset(dp, 0x3f, sizeof(dp));
    dp[0][0] = 0;

    for (int i = 0; i < costsSize; i++) {
        for (int j = m; j > 0; j--) {
            for (int k = target; k > 0; k--) {
                for (int l = 0; l < n; l++) {
                    if (j > 0 && k > 0) {
                        dp[j][k] = fmin(dp[j][k], dp[j - 1][k - 1] + costs[i][l]);
                    }
                }
            }
        }
    }

    int ans = INT_MAX;
    for (int j = 0; j <= target; j++) {
        ans = fmin(ans, dp[m][j]);
    }
    return ans == 0x3f3f3f3f ? -1 : ans;
}