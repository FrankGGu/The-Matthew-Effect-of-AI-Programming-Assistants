class Solution {
    private static final int MOD = 1_000_000_007;

    public int distinctSequences(int n) {
        if (n == 1) {
            return 6;
        }
        int[][][] dp = new int[n + 1][7][7];
        for (int i = 1; i <= 6; i++) {
            for (int j = 1; j <= 6; j++) {
                if (i != j && gcd(i, j) == 1) {
                    dp[2][i][j] = 1;
                }
            }
        }
        for (int len = 3; len <= n; len++) {
            for (int prev = 1; prev <= 6; prev++) {
                for (int curr = 1; curr <= 6; curr++) {
                    if (prev != curr && gcd(prev, curr) == 1) {
                        for (int prePrev = 1; prePrev <= 6; prePrev++) {
                            if (prePrev != curr) {
                                dp[len][prev][curr] = (dp[len][prev][curr] + dp[len - 1][prePrev][prev]) % MOD;
                            }
                        }
                    }
                }
            }
        }
        int res = 0;
        for (int i = 1; i <= 6; i++) {
            for (int j = 1; j <= 6; j++) {
                res = (res + dp[n][i][j]) % MOD;
            }
        }
        return res;
    }

    private int gcd(int a, int b) {
        return b == 0 ? a : gcd(b, a % b);
    }
}