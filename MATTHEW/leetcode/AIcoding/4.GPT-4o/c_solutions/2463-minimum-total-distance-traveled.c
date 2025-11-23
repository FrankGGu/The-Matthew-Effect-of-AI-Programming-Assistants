int minimumTotalDistance(int** robot, int robotSize, int* robotColSize, int** factory, int factorySize, int* factoryColSize) {
    int dp[robotSize + 1][factorySize + 1];
    memset(dp, 0x3f, sizeof(dp));
    dp[0][0] = 0;

    for (int i = 0; i <= robotSize; i++) {
        for (int j = 0; j <= factorySize; j++) {
            if (j > 0) {
                dp[i][j] = dp[i][j - 1]; 
            }
            if (i > 0 && j > 0) {
                int total = 0;
                for (int k = 0; k <= i; k++) {
                    total += robot[k][0];
                }
                for (int k = 0; k <= factory[j - 1][0]; k++) {
                    int dist = abs(total - factory[j - 1][0]);
                    dp[i][j] = fmin(dp[i][j], dp[i - 1][j - 1] + dist);
                }
            }
        }
    }

    return dp[robotSize][factorySize];
}