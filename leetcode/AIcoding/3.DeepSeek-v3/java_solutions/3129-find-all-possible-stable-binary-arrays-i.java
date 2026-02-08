class Solution {
    public int numberOfStableArrays(int zero, int one, int limit) {
        int MOD = 1_000_000_007;
        int[][][] dp = new int[zero + 1][one + 1][2];
        if (zero > 0) dp[1][0][0] = 1;
        if (one > 0) dp[0][1][1] = 1;

        for (int z = 0; z <= zero; z++) {
            for (int o = 0; o <= one; o++) {
                if (z == 0 && o == 0) continue;
                for (int last = 0; last < 2; last++) {
                    if (dp[z][o][last] == 0) continue;
                    if (last == 0) {
                        for (int k = 1; k <= limit && o + k <= one; k++) {
                            dp[z][o + k][1] = (dp[z][o + k][1] + dp[z][o][0]) % MOD;
                        }
                    } else {
                        for (int k = 1; k <= limit && z + k <= zero; k++) {
                            dp[z + k][o][0] = (dp[z + k][o][0] + dp[z][o][1]) % MOD;
                        }
                    }
                }
            }
        }

        return (dp[zero][one][0] + dp[zero][one][1]) % MOD;
    }
}