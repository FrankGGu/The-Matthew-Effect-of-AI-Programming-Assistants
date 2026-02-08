public class Solution {
    public boolean stoneGame(int[] piles) {
        int n = piles.length;
        boolean[][] dp = new boolean[n][n];

        for (int i = 0; i < n; i++) {
            dp[i][i] = true;
        }

        for (int length = 2; length <= n; length++) {
            for (int i = 0; i <= n - length; i++) {
                int j = i + length - 1;
                dp[i][j] = (piles[i] - piles[j]) > (dp[i + 1][j - 1] ? 0 : -1);
            }
        }

        return dp[0][n - 1];
    }
}