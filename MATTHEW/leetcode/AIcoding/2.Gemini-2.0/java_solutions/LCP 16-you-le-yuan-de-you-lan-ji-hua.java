import java.util.*;

class Solution {
    public int minCost(int maxCost, int[] cost, int[] time) {
        int n = cost.length;
        int[][] dp = new int[n + 1][maxCost + 1];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= maxCost; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j >= cost[i - 1]) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - cost[i - 1]] + time[i - 1]);
                }
            }
        }

        int ans = Integer.MAX_VALUE;
        for (int j = 0; j <= maxCost; j++) {
            ans = Math.min(ans, dp[n][j]);
        }

        return ans;
    }
}