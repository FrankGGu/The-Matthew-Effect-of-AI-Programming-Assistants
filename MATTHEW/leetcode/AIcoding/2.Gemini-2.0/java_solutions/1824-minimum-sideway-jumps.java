class Solution {
    public int minSideJumps(int[] obstacles) {
        int n = obstacles.length - 1;
        int[][] dp = new int[n + 1][3];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j < 3; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }
        dp[0][1] = 0;
        dp[0][0] = 1;
        dp[0][2] = 1;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < 3; j++) {
                if (obstacles[i] != j + 1) {
                    dp[i][j] = dp[i - 1][j];
                }
            }

            for (int j = 0; j < 3; j++) {
                if (obstacles[i] != j + 1) {
                    for (int k = 0; k < 3; k++) {
                        if (j != k && obstacles[i] != k + 1) {
                            dp[i][j] = Math.min(dp[i][j], dp[i][k] + 1);
                            dp[i][j] = Math.min(dp[i][j], dp[i-1][k] + 1);
                        }
                    }
                }
            }
            for (int j = 0; j < 3; j++) {
                if (obstacles[i] != j + 1) {
                    for (int k = 0; k < 3; k++) {
                        if (j != k && obstacles[i-1] != k + 1 && obstacles[i] != k + 1) {
                            dp[i][j] = Math.min(dp[i][j], dp[i-1][k] + 1);
                        }
                    }
                }
            }

        }

        return Math.min(dp[n][0], Math.min(dp[n][1], dp[n][2]));
    }
}