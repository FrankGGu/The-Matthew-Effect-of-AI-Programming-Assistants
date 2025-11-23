class Solution {
    public int maxEnjoyment(int[][] rides) {
        int n = rides.length;
        int[] dp = new int[n + 1];

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            for (int j = 0; j < i; j++) {
                dp[i] = Math.max(dp[i], dp[j] + rides[j][1]);
            }
        }

        return dp[n];
    }
}