bool validPartition(int* nums, int numsSize) {
    if (numsSize < 2) return false;
    bool dp[numsSize + 1];
    dp[0] = true;

    for (int i = 2; i <= numsSize; ++i) {
        dp[i] = false;
        if (nums[i - 1] == nums[i - 2]) {
            dp[i] |= dp[i - 2];
        }
        if (i > 2 && nums[i - 1] == nums[i - 2] && nums[i - 2] == nums[i - 3]) {
            dp[i] |= dp[i - 3];
        }
        if (i > 2 && nums[i - 1] == nums[i - 2] + 1 && nums[i - 2] == nums[i - 3] + 1) {
            dp[i] |= dp[i - 3];
        }
    }
    return dp[numsSize];
}