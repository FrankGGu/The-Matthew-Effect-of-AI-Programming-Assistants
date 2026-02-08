int findTargetSumWays(int* nums, int numsSize, int target) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    if (target > sum || target < -sum) return 0;

    int total = sum * 2 + 1;
    int dp[total];
    int next[total];

    for (int i = 0; i < total; i++) {
        dp[i] = 0;
    }
    dp[sum] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < total; j++) {
            next[j] = 0;
        }

        for (int j = 0; j < total; j++) {
            if (dp[j] > 0) {
                if (j + nums[i] < total) {
                    next[j + nums[i]] += dp[j];
                }
                if (j - nums[i] >= 0) {
                    next[j - nums[i]] += dp[j];
                }
            }
        }

        for (int j = 0; j < total; j++) {
            dp[j] = next[j];
        }
    }

    return dp[sum + target];
}