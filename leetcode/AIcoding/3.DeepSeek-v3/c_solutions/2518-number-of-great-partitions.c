int countPartitions(int* nums, int numsSize, int k) {
    long long mod = 1e9 + 7;
    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    if (total < 2 * k) return 0;

    long long dp[k];
    for (int i = 0; i < k; i++) dp[i] = 0;
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = k - 1; j >= nums[i]; j--) {
            dp[j] = (dp[j] + dp[j - nums[i]]) % mod;
        }
    }

    long long sum = 0;
    for (int i = 0; i < k; i++) {
        sum = (sum + dp[i]) % mod;
    }

    long long total_ways = 1;
    for (int i = 0; i < numsSize; i++) {
        total_ways = (total_ways * 2) % mod;
    }

    long long result = (total_ways - 2 * sum + mod) % mod;
    return result > 0 ? result : 0;
}