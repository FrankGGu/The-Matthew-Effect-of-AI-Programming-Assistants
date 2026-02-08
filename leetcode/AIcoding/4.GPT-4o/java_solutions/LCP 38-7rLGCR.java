public class Solution {
    public int guardCastle(int[][] walls) {
        int n = walls.length;
        int m = walls[0].length;
        int[][] dp = new int[n][m];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                dp[i][j] = walls[i][j];
                if (i > 0) dp[i][j] += Math.max(0, dp[i - 1][j]);
                if (j > 0) dp[i][j] += Math.max(0, dp[i][j - 1]);
            }
        }

        return dp[n - 1][m - 1];
    }
}