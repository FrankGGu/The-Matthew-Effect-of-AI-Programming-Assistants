int minCost(int** costs, int costsSize, int* costsColSize) {
    int dp[costsSize + 1];
    for (int i = 0; i <= costsSize; i++) {
        dp[i] = 0;
    }

    for (int i = 1; i <= costsSize; i++) {
        dp[i] = INT_MAX;
        for (int j = 0; j < costsColSize[i - 1]; j++) {
            dp[i] = fmin(dp[i], dp[i - 1] + costs[i - 1][j]);
        }
    }

    return dp[costsSize];
}