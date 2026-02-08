class Solution {
    public int minSideJumps(int[] obstacles) {
        int n = obstacles.length;
        int[][] dp = new int[n][3];
        dp[0][0] = 1;
        dp[0][1] = 0;
        dp[0][2] = 1;

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < 3; j++) {
                if (obstacles[i] == j + 1) {
                    dp[i][j] = Integer.MAX_VALUE;
                } else {
                    dp[i][j] = dp[i - 1][j];
                }
            }

            for (int j = 0; j < 3; j++) {
                if (obstacles[i] != j + 1) {
                    int min = Integer.MAX_VALUE;
                    for (int k = 0; k < 3; k++) {
                        if (k != j && obstacles[i] != k + 1) {
                            min = Math.min(min, dp[i][k]);
                        }
                    }
                    if (min != Integer.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], min + 1);
                    }
                }
            }
        }

        return Math.min(dp[n - 1][0], Math.min(dp[n - 1][1], dp[n - 1][2]));
    }
}