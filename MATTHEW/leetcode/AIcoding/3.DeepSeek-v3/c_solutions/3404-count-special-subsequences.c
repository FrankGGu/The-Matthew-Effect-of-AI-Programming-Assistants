int countSpecialSubsequences(int* nums, int numsSize) {
    long long mod = 1e9 + 7;
    long long dp0 = 0, dp1 = 0, dp2 = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            dp0 = (dp0 * 2 + 1) % mod;
        } else if (nums[i] == 1) {
            dp1 = (dp1 * 2 + dp0) % mod;
        } else {
            dp2 = (dp2 * 2 + dp1) % mod;
        }
    }

    return dp2;
}