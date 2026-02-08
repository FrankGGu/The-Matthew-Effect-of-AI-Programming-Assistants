class Solution {
    public int trainingPlan(int n, int[][] training) {
        int[][] dp = new int[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Integer.MIN_VALUE;
            }
        }
        dp[0][0] = 0;

        for (int i = 0; i < training.length; i++) {
            int day = training[i][0];
            int workout = training[i][1];
            for (int j = n; j >= day; j--) {
                for (int k = n; k >= workout; k--) {
                    if (dp[j - day][k - workout] != Integer.MIN_VALUE) {
                        dp[j][k] = Math.max(dp[j][k], dp[j - day][k - workout] + workout);
                    }
                }
            }
        }

        int maxWorkout = 0;
        for (int i = 0; i <= n; i++) {
            maxWorkout = Math.max(maxWorkout, dp[n][i]);
        }
        return maxWorkout;
    }
}