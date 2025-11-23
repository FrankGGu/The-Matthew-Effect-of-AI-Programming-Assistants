class Solution {
    public int collectTheLeaves(int[][] leaves) {
        int n = leaves.length;
        int[][] dp = new int[n][n];

        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (len == 1) {
                    dp[i][j] = leaves[i][0];
                } else if (len == 2) {
                    dp[i][j] = Math.max(leaves[i][0], leaves[j][0]);
                } else {
                    dp[i][j] = Integer.MAX_VALUE;
                    for (int k = i; k < j; k++) {
                        dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k + 1][j]);
                    }
                    dp[i][j] += leaves[i][0] + leaves[j][0];
                }
            }
        }

        return dp[0][n - 1];
    }
}