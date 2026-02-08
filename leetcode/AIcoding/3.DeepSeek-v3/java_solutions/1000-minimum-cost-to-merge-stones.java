class Solution {
    public int mergeStones(int[] stones, int K) {
        int n = stones.length;
        if ((n - 1) % (K - 1) != 0) {
            return -1;
        }

        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        int[][][] dp = new int[n][n][K + 1];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; k <= K; k++) {
                    dp[i][j][k] = Integer.MAX_VALUE;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            dp[i][i][1] = 0;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                for (int k = 2; k <= K; k++) {
                    for (int m = i; m < j; m += K - 1) {
                        if (dp[i][m][1] == Integer.MAX_VALUE || dp[m + 1][j][k - 1] == Integer.MAX_VALUE) {
                            continue;
                        }
                        dp[i][j][k] = Math.min(dp[i][j][k], dp[i][m][1] + dp[m + 1][j][k - 1]);
                    }
                }
                if (dp[i][j][K] != Integer.MAX_VALUE) {
                    dp[i][j][1] = dp[i][j][K] + prefixSum[j + 1] - prefixSum[i];
                }
            }
        }

        return dp[0][n - 1][1];
    }
}