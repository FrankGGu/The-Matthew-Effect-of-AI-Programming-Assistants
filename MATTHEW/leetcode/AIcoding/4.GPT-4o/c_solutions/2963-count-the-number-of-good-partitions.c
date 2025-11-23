int countGoodPartitions(int *nums, int numsSize) {
    int mod = 1e9 + 7;
    long long dp[numsSize + 1];
    dp[0] = 1;
    int count[101] = {0};

    for (int i = 1; i <= numsSize; i++) {
        dp[i] = dp[i - 1] * 2 % mod;
        count[nums[i - 1]]++;

        while (count[nums[i - 1]] > 1) {
            dp[i] = (dp[i] - dp[i - count[nums[i - 1]] - 1] + mod) % mod;
            count[nums[i - 1]]--;
        }
    }

    return dp[numsSize] - 1;
}