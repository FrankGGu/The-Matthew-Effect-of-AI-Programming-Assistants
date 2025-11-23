int dp[1001][32][2];

int numberOfSubsequences(int* nums, int numsSize, int k) {
    int n = numsSize;
    memset(dp, 0, sizeof(dp));
    dp[0][0][0] = 1;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < 32; j++) {
            for (int sign = 0; sign < 2; sign++) {
                if (dp[i][j][sign] == 0) continue;

                dp[i+1][j][sign] = (dp[i+1][j][sign] + dp[i][j][sign]) % 1000000007;

                int new_j = j + nums[i];
                int new_sign = 1 - sign;

                if (sign == 0) {
                    new_j = j - nums[i];
                    new_sign = 1;
                }

                if (new_j >= 0 && new_j < 32) {
                    dp[i+1][new_j][new_sign] = (dp[i+1][new_j][new_sign] + dp[i][j][sign]) % 1000000007;
                }
            }
        }
    }

    int result = 0;
    for (int sign = 0; sign < 2; sign++) {
        if (sign == 0) {
            if (k >= 0 && k < 32) {
                result = (result + dp[n][k][sign]) % 1000000007;
            }
        } else {
            if (-k >= 0 && -k < 32) {
                result = (result + dp[n][-k][sign]) % 1000000007;
            }
        }
    }

    return result;
}