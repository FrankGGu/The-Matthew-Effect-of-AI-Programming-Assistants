class Solution {
    public int distinctSequences(int n) {
        int MOD = 1000000007;
        int[][] dp = new int[n + 1][6];
        int[][] last = new int[n + 1][6];

        for (int i = 0; i < 6; i++) {
            dp[1][i] = 1;
        }

        for (int i = 2; i <= n; i++) {
            for (int j = 0; j < 6; j++) {
                for (int k = 0; k < 6; k++) {
                    if (j != k && gcd(j + 1, k + 1) == 1) {
                        dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD;
                    }
                }
            }
        }

        int ans = 0;
        for (int i = 0; i < 6; i++) {
            ans = (ans + dp[n][i]) % MOD;
        }

        return ans;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}