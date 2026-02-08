#define MOD 1000000007

int countPartitions(int n, int k, int* nums, int numsSize) {
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    if (totalSum < k) return 0;

    long long target = (totalSum - k) / 2;
    if ((totalSum - k) % 2 != 0) return 0;

    long long dp[target + 1];
    memset(dp, 0, sizeof(dp));
    dp[0] = 1;

    for (int num = 0; num < numsSize; num++) {
        for (long long j = target; j >= nums[num]; j--) {
            dp[j] = (dp[j] + dp[j - nums[num]]) % MOD;
        }
    }

    return dp[target];
}