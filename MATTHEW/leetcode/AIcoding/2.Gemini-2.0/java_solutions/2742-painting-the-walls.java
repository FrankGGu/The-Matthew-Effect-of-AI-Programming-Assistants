class Solution {
    public int paintWalls(int[] cost, int[] time) {
        int n = cost.length;
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            dp[i] = 1000000000;
        }
        for (int i = 0; i < n; i++) {
            for (int j = n; j > 0; j--) {
                dp[j] = Math.min(dp[j], dp[Math.max(0, j - time[i] - 1)] + cost[i]);
            }
        }
        return dp[n];
    }
}