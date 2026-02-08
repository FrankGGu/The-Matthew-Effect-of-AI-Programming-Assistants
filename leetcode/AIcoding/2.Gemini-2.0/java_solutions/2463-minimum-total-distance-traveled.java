import java.util.Arrays;

class Solution {
    public int minimumTotalDistance(int[] robots, int[][] factories) {
        Arrays.sort(robots);
        Arrays.sort(factories, (a, b) -> a[0] - b[0]);
        int n = robots.length;
        int m = factories.length;
        int[][] dp = new int[n + 1][m + 1];
        for (int i = 1; i <= n; i++) {
            dp[i][0] = Integer.MAX_VALUE;
        }
        for (int j = 1; j <= m; j++) {
            int[] prefixSum = new int[n + 1];
            for (int i = 1; i <= n; i++) {
                prefixSum[i] = prefixSum[i - 1] + Math.abs(robots[i - 1] - factories[j - 1][0]);
            }
            for (int i = 0; i <= n; i++) {
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = 0; k <= Math.min(i, factories[j - 1][1]); k++) {
                    if (i - k >= 0 && dp[i - k][j - 1] != Integer.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - k][j - 1] + (prefixSum[i] - prefixSum[i - k]));
                    }
                }
            }
        }
        return dp[n][m];
    }
}