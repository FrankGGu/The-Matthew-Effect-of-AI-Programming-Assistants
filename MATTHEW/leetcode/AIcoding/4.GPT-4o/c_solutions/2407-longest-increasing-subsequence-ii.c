int lengthOfLIS(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    int len = 0;

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j] && nums[i] - nums[j] <= k) {
                dp[i] = fmax(dp[i], dp[j] + 1);
            }
        }
        len = fmax(len, dp[i]);
    }

    free(dp);
    return len;
}