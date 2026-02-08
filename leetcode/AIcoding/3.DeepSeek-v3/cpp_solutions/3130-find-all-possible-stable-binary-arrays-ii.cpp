class Solution {
public:
    const int MOD = 1e9 + 7;
    int numberOfStableArrays(int zero, int one, int limit) {
        int dp[zero + 1][one + 1][2];
        memset(dp, 0, sizeof(dp));

        for (int z = 0; z <= zero; ++z) {
            for (int o = 0; o <= one; ++o) {
                if (z == 0 && o == 0) {
                    dp[z][o][0] = 0;
                    dp[z][o][1] = 0;
                } else if (z == 0) {
                    if (o <= limit) {
                        dp[z][o][0] = 0;
                        dp[z][o][1] = 1;
                    } else {
                        dp[z][o][0] = 0;
                        dp[z][o][1] = 0;
                    }
                } else if (o == 0) {
                    if (z <= limit) {
                        dp[z][o][0] = 1;
                        dp[z][o][1] = 0;
                    } else {
                        dp[z][o][0] = 0;
                        dp[z][o][1] = 0;
                    }
                } else {
                    for (int k = 1; k <= min(z, limit); ++k) {
                        dp[z][o][0] = (dp[z][o][0] + dp[z - k][o][1]) % MOD;
                    }
                    for (int k = 1; k <= min(o, limit); ++k) {
                        dp[z][o][1] = (dp[z][o][1] + dp[z][o - k][0]) % MOD;
                    }
                }
            }
        }

        return (dp[zero][one][0] + dp[zero][one][1]) % MOD;
    }
};