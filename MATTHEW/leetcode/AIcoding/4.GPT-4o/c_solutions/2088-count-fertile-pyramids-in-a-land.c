int countPyramids(int** land, int landSize, int* landColSize) {
    int count = 0;
    int dp[landSize][landColSize[0]];

    for (int i = 0; i < landSize; i++) {
        for (int j = 0; j < landColSize[0]; j++) {
            if (land[i][j] == 1) {
                dp[i][j] = (i == 0 || j == 0 || j == landColSize[0] - 1) ? 1 : 1 + (dp[i - 1][j - 1] < dp[i - 1][j] ? dp[i - 1][j - 1] : dp[i - 1][j]);
                count += dp[i][j];
            } else {
                dp[i][j] = 0;
            }
        }
    }
    return count;
}