import java.util.*;

class Solution {
    public List<Integer> dieSimulator(int n, int[] rollMax) {
        int MOD = 1000000007;
        long[][] dp = new long[n + 1][7];
        long[][] sum = new long[n + 1][7];

        for (int i = 1; i <= 6; i++) {
            dp[1][i] = 1;
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= 6; j++) {
                sum[i][j] = (sum[i][j - 1] + dp[i][j]) % MOD;
            }
        }

        for (int i = 2; i <= n; i++) {
            for (int j = 1; j <= 6; j++) {
                for (int k = 1; k <= rollMax[j - 1] && k < i; k++) {
                    dp[i][j] = (dp[i][j] + (sum[i - k][6] - sum[i - k][j - 1] + MOD) % MOD) % MOD;
                }
            }
            for (int j = 1; j <= 6; j++) {
                sum[i][j] = (sum[i][j - 1] + dp[i][j]) % MOD;
            }
        }

        List<Integer> result = new ArrayList<>();
        for (int j = 1; j <= 6; j++) {
            result.add((int)(dp[n][j] % MOD));
        }
        return result;
    }
}