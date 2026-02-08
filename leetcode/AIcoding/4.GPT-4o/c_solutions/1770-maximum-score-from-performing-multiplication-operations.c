int maximumScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int dp[1001][1001] = {0}; 
    for (int i = 0; i <= multipliersSize; i++) {
        for (int j = 0; j <= i; j++) {
            int k = numsSize - 1 - (i - j);
            if (j > 0) {
                dp[i][j] = dp[i - 1][j - 1] + nums[j - 1] * multipliers[i - 1];
            }
            if (k >= 0) {
                dp[i][j] = fmax(dp[i][j], dp[i - 1][j] + nums[k] * multipliers[i - 1]);
            }
        }
    }
    int maxScore = 0;
    for (int j = 0; j <= multipliersSize; j++) {
        maxScore = fmax(maxScore, dp[multipliersSize][j]);
    }
    return maxScore;
}