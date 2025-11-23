int maximizeScore(int* nums, int numsSize, int* multipliers, int multipliersSize) {
    int dp[1001][1001] = {0};
    for (int i = 0; i < multipliersSize; i++) {
        for (int j = 0; j <= i; j++) {
            int left = nums[j] * multipliers[i] + dp[i - 1][j + 1];
            int right = nums[numsSize - 1 - (i - j)] * multipliers[i] + dp[i - 1][j];
            dp[i][j] = fmax(left, right);
        }
    }
    return dp[multipliersSize - 1][0];
}