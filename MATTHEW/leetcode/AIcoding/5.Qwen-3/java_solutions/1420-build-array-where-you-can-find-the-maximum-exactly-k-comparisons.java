public class Solution {

import java.util.*;

public class Solution {
    public int numOfArrays(int n, int k) {
        int MOD = 1000000007;
        int[][] dp = new int[k + 1][n + 1];
        int[][] ways = new int[k + 1][n + 1];

        for (int i = 1; i <= n; i++) {
            dp[1][i] = 1;
            ways[1][i] = 1;
        }

        for (int i = 2; i <= k; i++) {
            for (int j = i; j <= n; j++) {
                for (int m = i - 1; m < j; m++) {
                    dp[i][j] = (dp[i][j] + ways[i - 1][m]) % MOD;
                    ways[i][j] = (ways[i][j] + ways[i - 1][m]) % MOD;
                }
            }
        }

        int result = 0;
        for (int i = 1; i <= n; i++) {
            result = (result + dp[k][i]) % MOD;
        }

        return result;
    }
}
}