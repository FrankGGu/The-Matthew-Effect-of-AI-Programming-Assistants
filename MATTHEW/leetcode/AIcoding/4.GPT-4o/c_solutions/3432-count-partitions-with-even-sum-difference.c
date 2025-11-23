int countPartitions(int* nums, int numsSize, int k) {
    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }
    if ((totalSum - k) % 2 != 0 || totalSum < k) return 0;

    int target = (totalSum - k) / 2;
    int* dp = (int*)malloc((target + 1) * sizeof(int));
    memset(dp, 0, (target + 1) * sizeof(int));
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = target; j >= nums[i]; j--) {
            dp[j] += dp[j - nums[i]];
        }
    }

    int result = dp[target];
    free(dp);
    return result;
}