import java.util.Arrays;

public class Solution {
    public int connectTwoGroups(int[][] cost) {
        int n = cost.length, m = cost[0].length;
        int[][] dp = new int[1 << n][m + 1];
        for (int[] row : dp) Arrays.fill(row, Integer.MAX_VALUE);
        dp[0][0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            for (int j = 0; j < m; j++) {
                if (dp[mask][j] == Integer.MAX_VALUE) continue;
                for (int i = 0; i < n; i++) {
                    dp[mask | (1 << i)][j + 1] = Math.min(dp[mask | (1 << i)][j + 1], dp[mask][j] + cost[i][j]);
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int j = 0; j <= m; j++) {
            result = Math.min(result, dp[(1 << n) - 1][j]);
        }
        return result;
    }
}