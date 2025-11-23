int getMoneyAmount(int n) {
    int dp[n+1][n+1];
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    for (int len = 2; len <= n; len++) {
        for (int start = 1; start <= n - len + 1; start++) {
            int end = start + len - 1;
            int minCost = INT_MAX;
            for (int k = start; k < end; k++) {
                int cost = k + (dp[start][k-1] > dp[k+1][end] ? dp[start][k-1] : dp[k+1][end]);
                if (cost < minCost) {
                    minCost = cost;
                }
            }
            dp[start][end] = minCost;
        }
    }

    return dp[1][n];
}