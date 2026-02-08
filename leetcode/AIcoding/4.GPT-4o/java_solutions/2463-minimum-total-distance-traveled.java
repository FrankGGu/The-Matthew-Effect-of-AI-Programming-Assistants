class Solution {
    public int minimumTotalDistance(int[][] robot, int[][] factory) {
        int m = robot.length, n = factory.length;
        int[][] dp = new int[m + 1][n + 1];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 0; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                dp[i][j] = dp[i][j - 1];
                int distance = 0;
                for (int k = 1; k <= i; k++) {
                    distance += Math.abs(robot[i - k][0] - factory[j - 1][0]) + Math.abs(robot[i - k][1] - factory[j - 1][1]);
                    dp[i][j] = Math.min(dp[i][j], dp[i - k][j - 1] + distance);
                }
            }
        }
        return dp[m][n] == Integer.MAX_VALUE ? -1 : dp[m][n];
    }
}