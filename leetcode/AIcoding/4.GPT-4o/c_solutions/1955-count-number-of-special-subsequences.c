#define MOD 1000000007

int countSpecialSubsequences(int* nums, int numsSize) {
    long long dp[numsSize + 1][4];
    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j < 4; j++) {
            dp[i][j] = 0;
        }
    }
    dp[0][0] = 1;

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < 4; j++) {
            dp[i + 1][j] = (dp[i][j] * 2) % MOD;
        }
        if (nums[i] == 0) {
            dp[i + 1][0] = (dp[i][0] + dp[i][0]) % MOD;
        } else if (nums[i] == 1) {
            dp[i + 1][1] = (dp[i][0] + dp[i][1]) % MOD;
        } else if (nums[i] == 2) {
            dp[i + 1][2] = (dp[i][1] + dp[i][2]) % MOD;
        } else if (nums[i] == 3) {
            dp[i + 1][3] = (dp[i][2] + dp[i][3]) % MOD;
        }
    }

    return (int)(dp[numsSize][3] - 1 + MOD) % MOD;
}