class Solution {
    public int findMinimumTime(int[][] rooms) {
        int m = rooms.length;
        int n = rooms[0].length;
        int[][] dp = new int[m][n];
        dp[0][0] = rooms[0][0];

        for (int i = 1; i < m; i++) {
            dp[i][0] = Math.max(dp[i-1][0], rooms[i][0]);
        }

        for (int j = 1; j < n; j++) {
            dp[0][j] = Math.max(dp[0][j-1], rooms[0][j]);
        }

        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                dp[i][j] = Math.max(Math.min(dp[i-1][j], dp[i][j-1]), rooms[i][j]);
            }
        }

        return dp[m-1][n-1];
    }
}