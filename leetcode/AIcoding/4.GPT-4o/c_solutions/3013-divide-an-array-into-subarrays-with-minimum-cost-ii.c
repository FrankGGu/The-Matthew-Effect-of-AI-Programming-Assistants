int minCost(int* nums, int numsSize, int k) {
    int dp[numsSize + 1];
    int freq[100001] = {0};
    for (int i = 0; i <= numsSize; i++) {
        dp[i] = i == 0 ? 0 : INT_MAX;
    }
    for (int i = 1; i <= numsSize; i++) {
        int distinct = 0;
        for (int j = i; j > 0 && j >= i - k; j--) {
            if (freq[nums[j - 1]]++ == 0) distinct++;
            dp[i] = fmin(dp[i], dp[j - 1] + distinct);
        }
        for (int j = i; j > 0 && j >= i - k; j--) {
            freq[nums[j - 1]]--;
        }
    }
    return dp[numsSize];
}