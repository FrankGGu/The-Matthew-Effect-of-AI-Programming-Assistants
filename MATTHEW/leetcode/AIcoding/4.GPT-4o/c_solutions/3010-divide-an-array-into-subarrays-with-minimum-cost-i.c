int minCost(int* nums, int numsSize, int k) {
    int dp[numsSize + 1];
    int freq[100001] = {0};
    for (int i = 0; i <= numsSize; i++) dp[i] = 0x3f3f3f3f;
    dp[0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        int uniqueCount = 0;
        for (int j = i; j > 0; j--) {
            if (freq[nums[j - 1]] == 0) uniqueCount++;
            freq[nums[j - 1]]++;
            dp[i] = fmin(dp[i], dp[j - 1] + uniqueCount);
        }
        for (int j = i; j > 0; j--) {
            freq[nums[j - 1]]--;
        }
    }

    return dp[numsSize];
}