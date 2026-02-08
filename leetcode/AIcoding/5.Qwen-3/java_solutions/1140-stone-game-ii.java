public class Solution {
    public int stoneGameII(int[] piles) {
        int n = piles.length;
        int[] suffixSum = new int[n];
        suffixSum[n - 1] = piles[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            suffixSum[i] = suffixSum[i + 1] + piles[i];
        }

        int[][] dp = new int[n][n];

        for (int i = 0; i < n; i++) {
            dp[i][i] = piles[i];
        }

        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                int total = suffixSum[i] - (i == 0 ? 0 : suffixSum[i - 1]);
                for (int k = i; k < j; k++) {
                    int take = total - dp[k + 1][j];
                    dp[i][j] = Math.max(dp[i][j], take);
                }
            }
        }

        return dp[0][n - 1];
    }
}