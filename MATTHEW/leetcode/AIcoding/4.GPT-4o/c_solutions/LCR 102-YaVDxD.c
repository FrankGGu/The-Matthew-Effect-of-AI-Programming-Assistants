int findTargetSumWays(int* nums, int numsSize, int target) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    if (target > sum || (sum + target) % 2 != 0) {
        return 0;
    }

    int s = (sum + target) / 2;
    int* dp = (int*)calloc(s + 1, sizeof(int));
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = s; j >= nums[i]; j--) {
            dp[j] += dp[j - nums[i]];
        }
    }

    int result = dp[s];
    free(dp);
    return result;
}