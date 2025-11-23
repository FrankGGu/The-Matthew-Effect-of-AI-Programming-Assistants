bool canPartition(int* nums, int numsSize) {
    int product = 1;
    for (int i = 0; i < numsSize; i++) {
        product *= nums[i];
    }
    if (product % 2 != 0) return false;
    product /= 2;

    bool dp[product + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = true;

    for (int i = 0; i < numsSize; i++) {
        for (int j = product; j >= nums[i]; j--) {
            dp[j] = dp[j] || dp[j - nums[i]];
        }
    }
    return dp[product];
}