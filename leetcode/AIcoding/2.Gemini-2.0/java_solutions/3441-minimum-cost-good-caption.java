import java.util.Arrays;

public class Solution {
    public int minimumCostGoodCaption(int[] a, int[] b, int k) {
        int n = a.length;
        int sumB = Arrays.stream(b).sum();
        int[][] dp = new int[n + 1][sumB + 1];

        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE);
        }

        dp[0][0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= sumB; j++) {
                dp[i][j] = dp[i - 1][j];
                if (j >= b[i - 1] && dp[i - 1][j - b[i - 1]] != Integer.MAX_VALUE) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - b[i - 1]] + a[i - 1]);
                }
            }
        }

        int minCost = Integer.MAX_VALUE;
        for (int j = k; j <= sumB; j++) {
            minCost = Math.min(minCost, dp[n][j]);
        }

        return minCost == Integer.MAX_VALUE ? -1 : minCost;
    }
}