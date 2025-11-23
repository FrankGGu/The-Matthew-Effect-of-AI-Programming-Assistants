import java.util.Arrays;

class Solution {
    public int minNumberofLevels(int[] levels, int[] points) {
        int n = levels.length;
        int[][] dp = new int[n + 1][2];
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }
        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i][0] = Math.min(dp[i - 1][0], dp[i - 1][1]);
            if (levels[i - 1] <= points[i - 1]) {
                if (dp[i - 1][0] != Integer.MAX_VALUE) {
                    dp[i][1] = dp[i - 1][0] + 1;
                }
                if (dp[i - 1][1] != Integer.MAX_VALUE) {
                    dp[i][1] = Math.min(dp[i][1], dp[i - 1][1] + 1);
                }
            }
        }

        return Math.min(dp[n][0], dp[n][1] == Integer.MAX_VALUE ? Integer.MAX_VALUE : dp[n][1]);
    }
}