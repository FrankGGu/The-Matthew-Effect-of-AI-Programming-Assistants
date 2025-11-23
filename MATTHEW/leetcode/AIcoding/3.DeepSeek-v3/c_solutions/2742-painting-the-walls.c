int minCost(int* cost, int costSize, int* time, int timeSize) {
    int n = costSize;
    int dp[n + 1];
    for (int i = 0; i <= n; i++) {
        dp[i] = 1e9;
    }
    dp[0] = 0;

    for (int i = 0; i < n; i++) {
        for (int j = n; j >= 0; j--) {
            int newJ = j + time[i] + 1;
            if (newJ > n) newJ = n;
            if (dp[j] != 1e9) {
                if (dp[newJ] > dp[j] + cost[i]) {
                    dp[newJ] = dp[j] + cost[i];
                }
            }
        }
    }

    return dp[n];
}