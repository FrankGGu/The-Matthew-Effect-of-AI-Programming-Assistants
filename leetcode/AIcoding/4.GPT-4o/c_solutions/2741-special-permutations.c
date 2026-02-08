int specialPerms(int* nums, int numsSize) {
    int mod = 1e9 + 7;
    long long dp[1 << 12][12] = {0};
    dp[0][0] = 1;

    for (int mask = 0; mask < (1 << numsSize); mask++) {
        int count = __builtin_popcount(mask);
        for (int j = 0; j < numsSize; j++) {
            if (!(mask & (1 << j))) {
                for (int k = 0; k < count; k++) {
                    if (count == 0 || nums[j] % nums[__builtin_ctz(mask)] == 0 || nums[__builtin_ctz(mask)] % nums[j] == 0) {
                        dp[mask | (1 << j)][j] = (dp[mask | (1 << j)][j] + dp[mask][k]) % mod;
                    }
                }
            }
        }
    }

    long long result = 0;
    for (int j = 0; j < numsSize; j++) {
        result = (result + dp[(1 << numsSize) - 1][j]) % mod;
    }

    return (int)result;
}