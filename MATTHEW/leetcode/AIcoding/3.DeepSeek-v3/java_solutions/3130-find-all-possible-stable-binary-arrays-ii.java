class Solution {
    private static final int MOD = 1_000_000_007;

    public int numberOfStableArrays(int zero, int one, int limit) {
        int[][][][] dp = new int[zero + 1][one + 1][2][limit + 1];
        for (int z = 0; z <= zero; z++) {
            for (int o = 0; o <= one; o++) {
                for (int last = 0; last < 2; last++) {
                    for (int cnt = 0; cnt <= limit; cnt++) {
                        if (z == 0 && o == 0) {
                            dp[z][o][last][cnt] = 1;
                        } else {
                            int res = 0;
                            if (last == 0 && z > 0 && cnt > 0) {
                                res = (res + dp[z - 1][o][0][cnt - 1]) % MOD;
                            }
                            if (last == 1 && o > 0 && cnt > 0) {
                                res = (res + dp[z][o - 1][1][cnt - 1]) % MOD;
                            }
                            if (last == 0 && o > 0) {
                                res = (res + dp[z][o - 1][1][limit]) % MOD;
                            }
                            if (last == 1 && z > 0) {
                                res = (res + dp[z - 1][o][0][limit]) % MOD;
                            }
                            dp[z][o][last][cnt] = res;
                        }
                    }
                }
            }
        }
        int ans = 0;
        ans = (ans + dp[zero][one][0][limit]) % MOD;
        ans = (ans + dp[zero][one][1][limit]) % MOD;
        return ans;
    }
}