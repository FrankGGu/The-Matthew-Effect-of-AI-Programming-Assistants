int minimumScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int dp[multipliersSize + 1][multipliersSize + 1];
    for (int i = 0; i <= multipliersSize; ++i)
        for (int j = 0; j <= multipliersSize; ++j)
            dp[i][j] = INT_MAX;

    dp[0][0] = 0;

    for (int i = 0; i < multipliersSize; ++i) {
        for (int j = 0; j <= i; ++j) {
            int leftIndex = j;
            int rightIndex = numsSize - 1 - (i - j);
            if (leftIndex < numsSize) {
                dp[i + 1][j] = fmin(dp[i + 1][j], dp[i][j] + multipliers[i] * nums[leftIndex]);
            }
            if (rightIndex >= 0) {
                dp[i + 1][j + 1] = fmin(dp[i + 1][j + 1], dp[i][j] + multipliers[i] * nums[rightIndex]);
            }
        }
    }

    int minScore = INT_MAX;
    for (int j = 0; j <= multipliersSize; ++j) {
        minScore = fmin(minScore, dp[multipliersSize][j]);
    }

    return minScore;
}