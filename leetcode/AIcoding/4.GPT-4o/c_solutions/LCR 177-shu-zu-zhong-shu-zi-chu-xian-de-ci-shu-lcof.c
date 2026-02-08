int minCostToPaint(int** costs, int costsSize, int* costsColSize) {
    if (costsSize == 0) return 0;

    int dp[costsSize][3];
    for (int j = 0; j < 3; j++) {
        dp[0][j] = costs[0][j];
    }

    for (int i = 1; i < costsSize; i++) {
        dp[i][0] = costs[i][0] + (dp[i-1][1] < dp[i-1][2] ? dp[i-1][1] : dp[i-1][2]);
        dp[i][1] = costs[i][1] + (dp[i-1][0] < dp[i-1][2] ? dp[i-1][0] : dp[i-1][2]);
        dp[i][2] = costs[i][2] + (dp[i-1][0] < dp[i-1][1] ? dp[i-1][0] : dp[i-1][1]);
    }

    int res = dp[costsSize-1][0];
    for (int j = 1; j < 3; j++) {
        if (dp[costsSize-1][j] < res) {
            res = dp[costsSize-1][j];
        }
    }

    return res;
}