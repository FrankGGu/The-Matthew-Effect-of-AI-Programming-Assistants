int minCost(int* houses, int housesSize, int** cost, int costSize, int* costColSize, int m, int n, int target) {
    int dp[101][101][21];
    for (int i = 0; i <= m; i++) {
        for (int j = 0; j <= target; j++) {
            for (int k = 0; k <= n; k++) {
                dp[i][j][k] = 1e9;
            }
        }
    }

    if (houses[0] == 0) {
        for (int k = 1; k <= n; k++) {
            dp[0][1][k] = cost[0][k-1];
        }
    } else {
        dp[0][1][houses[0]] = 0;
    }

    for (int i = 1; i < m; i++) {
        for (int j = 1; j <= target; j++) {
            if (houses[i] == 0) {
                for (int k = 1; k <= n; k++) {
                    for (int prevK = 1; prevK <= n; prevK++) {
                        if (k == prevK) {
                            if (dp[i-1][j][prevK] != 1e9) {
                                dp[i][j][k] = fmin(dp[i][j][k], dp[i-1][j][prevK] + cost[i][k-1]);
                            }
                        } else {
                            if (dp[i-1][j-1][prevK] != 1e9) {
                                dp[i][j][k] = fmin(dp[i][j][k], dp[i-1][j-1][prevK] + cost[i][k-1]);
                            }
                        }
                    }
                }
            } else {
                int k = houses[i];
                for (int prevK = 1; prevK <= n; prevK++) {
                    if (k == prevK) {
                        if (dp[i-1][j][prevK] != 1e9) {
                            dp[i][j][k] = fmin(dp[i][j][k], dp[i-1][j][prevK]);
                        }
                    } else {
                        if (dp[i-1][j-1][prevK] != 1e9) {
                            dp[i][j][k] = fmin(dp[i][j][k], dp[i-1][j-1][prevK]);
                        }
                    }
                }
            }
        }
    }

    int res = 1e9;
    for (int k = 1; k <= n; k++) {
        res = fmin(res, dp[m-1][target][k]);
    }
    return res == 1e9 ? -1 : res;
}