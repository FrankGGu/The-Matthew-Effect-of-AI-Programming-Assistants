public class Solution {
    public int paintWalls(int n, int k) {
        int[][] dp = new int[n + 1][2];
        dp[1][0] = k;
        dp[1][1] = k * (k - 1);

        for (int i = 2; i <= n; i++) {
            dp[i][0] = (dp[i - 1][0] + dp[i - 1][1]) * k;
            dp[i][1] = dp[i - 1][0] * (k - 1);
        }

        return dp[n][0] + dp[n][1];
    }
}