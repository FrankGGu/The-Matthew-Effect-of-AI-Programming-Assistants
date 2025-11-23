public class Solution {
    private static final int MOD = 1000000007;

    public int countWays(int m, int n) {
        int[][][][] dp = new int[m + 1][n + 1][2][2];
        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                for (int k = 0; k < 2; k++) {
                    for (int l = 0; l < 2; l++) {
                        dp[i][j][k][l] = -1;
                    }
                }
            }
        }

        return solve(m, n, 0, 0, dp);
    }

    private int solve(int ones, int zeros, int prevZero, int prevOne, int[][][][] dp) {
        if (ones < 0 || zeros < 0) {
            return 0;
        }

        if (ones == 0 && zeros == 0) {
            return 1;
        }

        if (dp[ones][zeros][prevZero][prevOne] != -1) {
            return dp[ones][zeros][prevZero][prevOne];
        }

        long ans = 0;

        if (prevZero == 0) {
            ans = (ans + solve(ones, zeros - 1, 1, 0, dp)) % MOD;
        }

        if (prevOne == 0) {
            ans = (ans + solve(ones - 1, zeros, 0, 1, dp)) % MOD;
        }

        dp[ones][zeros][prevZero][prevOne] = (int) ans;
        return dp[ones][zeros][prevZero][prevOne];
    }
}