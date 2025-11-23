class Solution {
    public int mergeStones(int[] stones, int k) {
        int n = stones.length;
        if ((n - 1) % (k - 1) != 0) {
            return -1;
        }

        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        int[][][] dp = new int[n][n][k + 1];
        for (int len = 1; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                dp[i][j][1] = (i == j) ? 0 : Integer.MAX_VALUE / 2;
                for (int m = 2; m <= k; m++) {
                    dp[i][j][m] = Integer.MAX_VALUE / 2;
                    for (int p = i; p < j; p++) {
                        dp[i][j][m] = Math.min(dp[i][j][m], dp[i][p][1] + dp[p + 1][j][m - 1]);
                    }
                }
                dp[i][j][1] = Math.min(dp[i][j][1], dp[i][j][k] + prefixSum[j + 1] - prefixSum[i]);
            }
        }

        return dp[0][n - 1][1];
    }
}