class Solution {
    public int stoneGameV(int[] stoneValue) {
        int n = stoneValue.length;

        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + stoneValue[i];
        }

        int[][] dp = new int[n][n];

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;

                for (int k = i + 1; k <= j; k++) {
                    int sumLeft = prefixSum[k] - prefixSum[i];
                    int sumRight = prefixSum[j + 1] - prefixSum[k];

                    int currentScore = 0;
                    int nextScore = 0;

                    if (sumLeft < sumRight) {
                        currentScore = sumLeft;
                        nextScore = dp[i][k - 1];
                    } else if (sumLeft > sumRight) {
                        currentScore = sumRight;
                        nextScore = dp[k][j];
                    } else { // sumLeft == sumRight
                        currentScore = sumLeft;
                        nextScore = Math.max(dp[i][k - 1], dp[k][j]);
                    }

                    dp[i][j] = Math.max(dp[i][j], currentScore + nextScore);
                }
            }
        }

        return dp[0][n - 1];
    }
}