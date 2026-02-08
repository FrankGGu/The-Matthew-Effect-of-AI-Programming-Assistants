#define MOD 1000000007

int countSpecialSubsequences(int* nums, int numsSize) {
    long long dp[numsSize + 1][4];
    for (int i = 0; i <= numsSize; i++) {
        for (int j = 0; j < 4; j++) {
            dp[i][j] = 0;
        }
    }

    dp[0][0] = 1;

    for (int i = 1; i <= numsSize; i++) {
        int num = nums[i - 1];
        for (int j = 0; j < 4; j++) {
            dp[i][j] = dp[i - 1][j] * 2 % MOD;
        }
        if (num == 0) {
            dp[i][0] = (dp[i][0] + dp[i - 1][0]) % MOD;
        } else if (num == 1) {
            dp[i][1] = (dp[i][1] + dp[i - 1][0]) % MOD;
        } else if (num == 2) {
            dp[i][2] = (dp[i][2] + dp[i - 1][1]) % MOD;
        } else if (num == 3) {
            dp[i][3] = (dp[i][3] + dp[i - 1][2]) % MOD;
        }
    }

    return (int)dp[numsSize][3];
}