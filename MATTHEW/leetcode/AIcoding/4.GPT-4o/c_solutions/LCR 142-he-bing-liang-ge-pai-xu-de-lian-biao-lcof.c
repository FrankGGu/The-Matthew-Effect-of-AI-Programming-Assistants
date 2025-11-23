int canCompleteTraining(int n, int m, int** energy, int energySize, int* energyColSize) {
    int dp[n + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < m; i++) {
        for (int j = n; j >= energy[i][0]; j--) {
            dp[j] = fmax(dp[j], dp[j - energy[i][0]] + energy[i][1]);
        }
    }

    return dp[n] >= n ? 1 : 0;
}