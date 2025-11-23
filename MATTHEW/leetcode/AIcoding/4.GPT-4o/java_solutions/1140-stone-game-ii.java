class Solution {
    public int stoneGameII(int[] piles) {
        int n = piles.length;
        int[][] dp = new int[n][n + 1];
        int[] sum = new int[n + 1];

        for (int i = 0; i < n; i++) {
            sum[i + 1] = sum[i] + piles[i];
        }

        for (int i = n - 1; i >= 0; i--) {
            for (int M = 1; M <= n; M++) {
                for (int x = 1; x <= 2 * M && i + x <= n; x++) {
                    dp[i][M] = Math.max(dp[i][M], sum[i + x] - dp[i + x][Math.max(M, x)]);
                }
            }
        }

        return dp[0][1];
    }
}