int minCost(int* nums, int numsSize, int k) {
    int dp[numsSize + 1][k + 1];
    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = (i == 0) ? 0 : INT_MAX;
        }
    }

    for (int j = 1; j <= k; j++) {
        for (int i = 1; i <= numsSize; i++) {
            int maxCount = 0;
            for (int m = i; m >= 1; m--) {
                maxCount = fmax(maxCount, nums[m - 1]);
                dp[i][j] = fmin(dp[i][j], dp[m - 1][j - 1] + maxCount);
            }
        }
    }

    return dp[numsSize][k];
}