int maxScore(int* nums, int numsSize, int x) {
    int dp[2];
    dp[0] = nums[0] - (nums[0] % 2 ? x : 0);
    dp[1] = nums[0] - (nums[0] % 2 ? 0 : x);

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] % 2) {
            dp[1] = nums[i] + (dp[1] > dp[0] - x ? dp[1] : dp[0] - x);
        } else {
            dp[0] = nums[i] + (dp[0] > dp[1] - x ? dp[0] : dp[1] - x);
        }
    }

    return dp[0] > dp[1] ? dp[0] : dp[1];
}