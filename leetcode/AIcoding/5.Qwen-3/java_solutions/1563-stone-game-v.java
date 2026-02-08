public class Solution {

import java.util.*;

public class Solution {
    public int stoneGameV(String s) {
        int n = s.length();
        int[][] dp = new int[n][n];
        int[][] sum = new int[n][n];

        for (int i = 0; i < n; i++) {
            sum[i][i] = s.charAt(i) - '0';
            for (int j = i + 1; j < n; j++) {
                sum[i][j] = sum[i][j - 1] + s.charAt(j) - '0';
            }
        }

        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                for (int k = i; k < j; k++) {
                    int left = sum[i][k];
                    int right = sum[k + 1][j];
                    if (left < right) {
                        dp[i][j] = Math.max(dp[i][j], dp[i][k] + left);
                    } else if (left > right) {
                        dp[i][j] = Math.max(dp[i][j], dp[k + 1][j] + right);
                    } else {
                        dp[i][j] = Math.max(dp[i][j], dp[i][k] + left);
                        dp[i][j] = Math.max(dp[i][j], dp[k + 1][j] + right);
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
}
}