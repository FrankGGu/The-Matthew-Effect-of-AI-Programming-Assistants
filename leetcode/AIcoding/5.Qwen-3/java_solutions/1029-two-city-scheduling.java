public class Solution {
    public int twoCityScheduling(int[] costs) {
        int n = costs.length / 2;
        int[][] dp = new int[n + 1][n + 1];

        for (int i = 1; i <= n; i++) {
            dp[i][0] = dp[i - 1][0] + costs[2 * i - 2];
        }

        for (int j = 1; j <= n; j++) {
            dp[0][j] = dp[0][j - 1] + costs[2 * j - 2];
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                dp[i][j] = Math.min(dp[i - 1][j] + costs[2 * i + 2 * j - 2], dp[i][j - 1] + costs[2 * i + 2 * j - 2]);
            }
        }

        return dp[n][n];
    }
}