#define MOD 1000000007

int countSubsets(int* nums, int numsSize, int maxSum) {
    long long dp[maxSum + 1];
    for (int i = 0; i <= maxSum; i++) {
        dp[i] = 0;
    }
    dp[0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = maxSum; j >= nums[i]; j--) {
            dp[j] = (dp[j] + dp[j - nums[i]]) % MOD;
        }
    }

    long long result = 0;
    for (int i = 0; i <= maxSum; i++) {
        result = (result + dp[i]) % MOD;
    }

    return result;
}