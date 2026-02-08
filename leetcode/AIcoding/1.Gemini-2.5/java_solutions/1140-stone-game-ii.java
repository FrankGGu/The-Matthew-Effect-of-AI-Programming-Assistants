class Solution {
    int[] piles;
    int n;
    int[] suffixSum;
    int[][] dp;

    public int stoneGameII(int[] piles) {
        this.piles = piles;
        n = piles.length;
        suffixSum = new int[n + 1];
        dp = new int[n + 1][n + 1];

        for (int i = n - 1; i >= 0; i--) {
            suffixSum[i] = suffixSum[i + 1] + piles[i];
        }

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = -1;
            }
        }

        return solve(0, 1);
    }

    private int solve(int i, int m) {
        if (i + 2 * m >= n) {
            return suffixSum[i];
        }

        if (dp[i][m] != -1) {
            return dp[i][m];
        }

        int maxStones = 0;
        for (int x = 1; x <= 2 * m; x++) {
            if (i + x > n) {
                break;
            }
            maxStones = Math.max(maxStones, suffixSum[i] - solve(i + x, Math.max(m, x)));
        }

        dp[i][m] = maxStones;
        return maxStones;
    }
}