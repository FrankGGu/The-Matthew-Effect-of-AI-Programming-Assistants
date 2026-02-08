public class Solution {

import java.util.*;

public class Solution {
    public int numberOfSets(int n, int k) {
        int MOD = 1000000007;
        int[][] dp = new int[k + 1][n + 1];

        for (int i = 0; i <= n; i++) {
            dp[0][i] = 1;
        }

        for (int i = 1; i <= k; i++) {
            for (int j = 1; j <= n; j++) {
                dp[i][j] = (dp[i][j - 1] + dp[i - 1][j - 1]) % MOD;
            }
        }

        return dp[k][n];
    }
}
}