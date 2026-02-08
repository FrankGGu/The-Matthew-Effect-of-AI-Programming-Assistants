int minCost(int** costs, int costsSize, int* costsColSize, int m, int n) {
    int dp[costsSize + 1][m + 1][n + 1];
    memset(dp, 0x3f, sizeof(dp));
    dp[0][0][0] = 0;

    for (int i = 0; i < costsSize; i++) {
        for (int j = 0; j <= m; j++) {
            for (int k = 0; k <= n; k++) {
                if (dp[i][j][k] == 0x3f3f3f3f) continue;
                for (int color = 0; color < n; color++) {
                    int newJ = j + (k == 0 ? 1 : 0);
                    int newK = (k == color) ? k : k + 1;
                    dp[i + 1][newJ][newK] = fmin(dp[i + 1][newJ][newK], dp[i][j][k] + costs[i][color]);
                }
            }
        }
    }

    int ans = 0x3f3f3f3f;
    for (int j = 0; j <= m; j++) {
        ans = fmin(ans, dp[costsSize][j][m]);
    }

    return ans == 0x3f3f3f3f ? -1 : ans;
}