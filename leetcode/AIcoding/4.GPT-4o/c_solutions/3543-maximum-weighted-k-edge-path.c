int maximumWeightedKEdgePath(int** edges, int edgesSize, int* edgesColSize, int k) {
    int n = edgesSize + 1;
    int dp[n][k + 1];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = -1;
        }
    }
    dp[0][0] = 0;

    for (int j = 1; j <= k; j++) {
        for (int i = 0; i < edgesSize; i++) {
            int u = edges[i][0], v = edges[i][1], w = edges[i][2];
            if (dp[u][j - 1] != -1) {
                dp[v][j] = fmax(dp[v][j], dp[u][j - 1] + w);
            }
            if (dp[v][j - 1] != -1) {
                dp[u][j] = fmax(dp[u][j], dp[v][j - 1] + w);
            }
        }
    }

    int maxWeight = 0;
    for (int i = 0; i < n; i++) {
        maxWeight = fmax(maxWeight, dp[i][k]);
    }
    return maxWeight;
}