class Solution {
    public int minSideJumps(int[] obstacles) {
        int n = obstacles.length;
        int[][] dp = new int[n][4];

        for (int i = 0; i < n; i++) {
            for (int j = 1; j <= 3; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }

        dp[0][1] = 0;
        dp[0][2] = 1;
        dp[0][3] = 1;

        for (int i = 0; i < n - 1; i++) {
            for (int j = 1; j <= 3; j++) {
                if (obstacles[i] != j) {
                    dp[i + 1][j] = Math.min(dp[i + 1][j], dp[i][j]);
                    for (int k = 1; k <= 3; k++) {
                        if (j != k && obstacles[i] != k) {
                            dp[i + 1][k] = Math.min(dp[i + 1][k], dp[i][j] + 1);
                        }
                    }
                }
            }
        }

        return Math.min(Math.min(dp[n - 1][2], dp[n - 1][3]), dp[n - 1][1]);
    }
}