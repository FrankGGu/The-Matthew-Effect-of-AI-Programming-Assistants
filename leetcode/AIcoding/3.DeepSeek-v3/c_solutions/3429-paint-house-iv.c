int minCost(int* houses, int housesSize, int** cost, int costSize, int* costColSize, int m, int n, int target) {
    int dp[m][n][target + 1];
    int INF = 1e9;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k <= target; k++) {
                dp[i][j][k] = INF;
            }
        }
    }

    for (int j = 0; j < n; j++) {
        if (houses[0] == 0) {
            dp[0][j][1] = cost[0][j];
        } else if (houses[0] - 1 == j) {
            dp[0][j][1] = 0;
        }
    }

    for (int i = 1; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (houses[i] != 0 && houses[i] - 1 != j) continue;
            int paintCost = (houses[i] == 0) ? cost[i][j] : 0;

            for (int k = 1; k <= target; k++) {
                for (int prevColor = 0; prevColor < n; prevColor++) {
                    if (prevColor == j) {
                        if (dp[i-1][prevColor][k] != INF) {
                            dp[i][j][k] = fmin(dp[i][j][k], dp[i-1][prevColor][k] + paintCost);
                        }
                    } else {
                        if (k > 1 && dp[i-1][prevColor][k-1] != INF) {
                            dp[i][j][k] = fmin(dp[i][j][k], dp[i-1][prevColor][k-1] + paintCost);
                        }
                    }
                }
            }
        }
    }

    int ans = INF;
    for (int j = 0; j < n; j++) {
        ans = fmin(ans, dp[m-1][j][target]);
    }
    return ans == INF ? -1 : ans;
}