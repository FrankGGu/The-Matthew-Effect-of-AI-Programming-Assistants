int numDistinct(int* nums, int numsSize) {
    int dp[numsSize + 1][numsSize + 1];
    for (int i = 0; i <= numsSize; i++) {
        dp[i][0] = 1;
    }
    for (int i = 1; i <= numsSize; i++) {
        for (int j = 1; j <= numsSize; j++) {
            dp[i][j] = dp[i - 1][j];
            if (nums[i - 1] == nums[j - 1]) {
                dp[i][j] += dp[i - 1][j - 1];
            }
        }
    }
    return dp[numsSize][numsSize];
}