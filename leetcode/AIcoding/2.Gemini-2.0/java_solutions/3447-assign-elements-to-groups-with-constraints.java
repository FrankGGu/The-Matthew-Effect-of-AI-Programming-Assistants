import java.util.*;

class Solution {
    public int waysToAssign(int n, int[] groupSizes) {
        int MOD = 1000000007;
        int m = groupSizes.length;
        long[][] dp = new long[n + 1][m + 1];
        dp[0][0] = 1;
        long[][] comb = new long[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            comb[i][0] = comb[i][i] = 1;
            for (int j = 1; j < i; j++) {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % MOD;
            }
        }

        for (int i = 1; i <= m; i++) {
            int size = groupSizes[i - 1];
            for (int j = 0; j <= n; j++) {
                for (int k = 0; k <= Math.min(j, size); k++) {
                    dp[j][i] = (dp[j][i] + (dp[j - k][i - 1] * comb[j][k]) % MOD) % MOD;
                }
            }
        }

        return (int) dp[n][m];
    }
}