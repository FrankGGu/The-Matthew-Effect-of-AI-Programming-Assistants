int canPartition(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }

    if (total % 2 != 0) return 0;

    int target = total / 2;
    int dp[target + 1];
    for (int i = 0; i <= target; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = target; j >= nums[i]; j--) {
            if (dp[j - nums[i]]) {
                dp[j] = 1;
            }
        }
    }

    return dp[target];
}