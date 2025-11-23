int minCost(int* nums, int numsSize) {
    int dp[numsSize + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        dp[i] = dp[i - 1] + nums[i - 1];
        for (int j = i - 1; j >= 0; j--) {
            int max_num = 0;
            for (int k = j; k < i; k++) {
                if (nums[k] > max_num) {
                    max_num = nums[k];
                }
            }
            dp[i] = fmin(dp[i], dp[j] + max_num);
        }
    }

    return dp[numsSize];
}