class Solution {
    public int minDifficulty(int[] jobDifficulty, int d) {
        int n = jobDifficulty.length;
        if (n < d) {
            return -1;
        }

        int[][] dp = new int[d + 1][n + 1];
        for (int i = 0; i <= d; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }

        dp[0][0] = 0;

        for (int i = 1; i <= d; i++) {
            for (int j = i; j <= n; j++) {
                int maxDifficulty = 0;
                for (int k = j; k >= i; k--) {
                    maxDifficulty = Math.max(maxDifficulty, jobDifficulty[k - 1]);
                    if (dp[i - 1][k - 1] != Integer.MAX_VALUE) {
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][k - 1] + maxDifficulty);
                    }
                }
            }
        }

        return dp[d][n];
    }
}