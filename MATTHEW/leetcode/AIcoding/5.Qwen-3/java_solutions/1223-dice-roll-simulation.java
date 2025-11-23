public class Solution {

import java.util.*;

public class Solution {
    public int dieSimulator(int n, int k) {
        int MOD = 1000000007;
        int[][] dp = new int[n + 1][k + 1];

        for (int i = 1; i <= k; i++) {
            dp[1][i] = 1;
        }

        for (int i = 2; i <= n; i++) {
            for (int j = 1; j <= k; j++) {
                for (int m = 1; m <= k; m++) {
                    if (m != j) {
                        dp[i][j] += dp[i - 1][m];
                        dp[i][j] %= MOD;
                    }
                }
            }
        }

        int result = 0;
        for (int i = 1; i <= k; i++) {
            result += dp[n][i];
            result %= MOD;
        }

        return result;
    }
}
}