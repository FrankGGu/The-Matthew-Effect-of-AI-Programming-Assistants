class Solution {
    public boolean canCross(int[] stones) {
        int n = stones.length;
        if (n == 0) return true;

        boolean[][] dp = new boolean[n][n + 1];
        dp[0][1] = true;

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < i; j++) {
                int k = stones[i] - stones[j];
                if (k < 0 || k > n) continue;

                if (dp[j][k - 1]) {
                    dp[i][k] = true;
                }
                if (dp[j][k]) {
                    dp[i][k + 1] = true;
                }
                if (dp[j][k + 1]) {
                    dp[i][k + 2] = true;
                }
            }
        }

        for (int i = 1; i <= n; i++) {
            if (dp[n - 1][i]) return true;
        }

        return false;
    }
}