int lengthOfLongestSubsequence(int* nums, int numsSize, int target) {
    int dp[target + 1];
    memset(dp, 0, sizeof(dp));

    for (int i = 0; i < numsSize; i++) {
        for (int j = target; j >= nums[i]; j--) {
            dp[j] = fmax(dp[j], dp[j - nums[i]] + 1);
        }
    }

    return dp[target];
}