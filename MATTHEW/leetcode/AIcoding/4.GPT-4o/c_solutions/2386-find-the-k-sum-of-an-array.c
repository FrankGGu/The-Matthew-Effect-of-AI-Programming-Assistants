int kSum(int* nums, int numsSize, int k) {
    int mod = 1e9 + 7;
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum = (sum + nums[i]) % mod;
    }
    if (k == 1) return sum;

    long long dp[k + 1][numsSize + 1];
    for (int i = 0; i <= k; i++) {
        for (int j = 0; j <= numsSize; j++) {
            if (i == 0) {
                dp[i][j] = (j == 0) ? 1 : 0;
            } else if (j == 0) {
                dp[i][j] = 0;
            } else {
                dp[i][j] = (dp[i][j - 1] + (i > 0 ? dp[i - 1][j - 1] : 0)) % mod;
            }
        }
    }
    return dp[k][numsSize];
}