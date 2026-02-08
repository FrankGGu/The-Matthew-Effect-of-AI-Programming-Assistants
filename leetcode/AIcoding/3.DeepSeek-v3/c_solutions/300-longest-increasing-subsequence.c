int lengthOfLIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int dp[numsSize];
    int maxLen = 1;

    for (int i = 0; i < numsSize; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (nums[i] > nums[j] && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
            }
        }
        if (dp[i] > maxLen) {
            maxLen = dp[i];
        }
    }

    return maxLen;
}