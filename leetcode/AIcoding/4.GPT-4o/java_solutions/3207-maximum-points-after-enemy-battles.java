class Solution {
    public int maxPoints(int[] points) {
        int n = points.length;
        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                dp[j] = Math.max(dp[j], dp[j - 1] + points[i]);
            }
        }
        return dp[n];
    }
}