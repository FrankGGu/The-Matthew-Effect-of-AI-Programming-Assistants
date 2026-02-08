class Solution {
    public long maxPoints(int[][] enemies, int[] points) {
        int n = enemies.length;
        long[] dp = new long[n];
        dp[0] = points[0] - enemies[0][0];

        for (int i = 1; i < n; i++) {
            dp[i] = Long.MIN_VALUE;
            for (int j = 0; j < i; j++) {
                if (Math.abs(enemies[i][1] - enemies[j][1]) <= enemies[i][0] - enemies[j][0]) {
                    dp[i] = Math.max(dp[i], dp[j] + points[i] - enemies[i][0]);
                }
            }
            dp[i] = Math.max(dp[i], (long)points[i] - enemies[i][0]);
        }

        long ans = Long.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            ans = Math.max(ans, dp[i]);
        }
        return ans;
    }
}