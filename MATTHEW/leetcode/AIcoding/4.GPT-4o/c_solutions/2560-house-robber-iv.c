int minCost(int* houses, int housesSize, int* cost, int costSize, int m, int target) {
    int dp[101][101][101] = {0};
    for (int i = 0; i <= 100; i++)
        for (int j = 0; j <= 100; j++)
            for (int k = 0; k <= 100; k++)
                dp[i][j][k] = INT_MAX;

    dp[0][0][0] = 0;

    for (int i = 0; i < housesSize; i++) {
        for (int j = 0; j <= target; j++) {
            for (int k = 0; k <= m; k++) {
                if (dp[i][j][k] == INT_MAX) continue;
                if (houses[i] != 0) {
                    dp[i + 1][j + (houses[i] != houses[i - 1])][k] = 
                        fmin(dp[i + 1][j + (houses[i] != houses[i - 1])][k], dp[i][j][k]);
                } else {
                    for (int color = 1; color <= m; color++) {
                        dp[i + 1][j + (color != houses[i - 1])][k + 1] = 
                            fmin(dp[i + 1][j + (color != houses[i - 1])][k + 1], dp[i][j][k] + cost[i][color - 1]);
                    }
                }
            }
        }
    }

    int result = INT_MAX;
    for (int k = 0; k <= m; k++) {
        result = fmin(result, dp[housesSize][target][k]);
    }

    return result == INT_MAX ? -1 : result;
}