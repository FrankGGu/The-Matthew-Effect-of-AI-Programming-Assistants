import java.util.*;

public class Solution {
    public int minCost(int[] houses, int cost, int m, int n, int target) {
        int[][][] dp = new int[m + 1][n + 1][target + 1];
        for (int[][] mat : dp) {
            for (int[] row : mat) {
                Arrays.fill(row, Integer.MAX_VALUE);
            }
        }
        dp[0][0][0] = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j <= target; j++) {
                for (int k = 1; k <= n; k++) {
                    if (houses[i] == 0) {
                        if (j > 0) {
                            dp[i + 1][k][j] = Math.min(dp[i + 1][k][j], dp[i][k][j] + cost);
                        }
                        dp[i + 1][k][j] = Math.min(dp[i + 1][k][j], dp[i][k - 1][j - 1]);
                    } else {
                        if (houses[i] == k) {
                            dp[i + 1][k][j] = Math.min(dp[i + 1][k][j], dp[i][k][j]);
                        } else {
                            if (j > 0) {
                                dp[i + 1][houses[i]][j] = Math.min(dp[i + 1][houses[i]][j], dp[i][k][j] + cost);
                            }
                            dp[i + 1][houses[i]][j] = Math.min(dp[i + 1][houses[i]][j], dp[i][k - 1][j - 1]);
                        }
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int k = 1; k <= n; k++) {
            result = Math.min(result, dp[m][k][target]);
        }

        return result == Integer.MAX_VALUE ? -1 : result;
    }
}