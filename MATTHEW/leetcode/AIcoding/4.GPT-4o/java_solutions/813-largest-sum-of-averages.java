class Solution {
    public double largestSumOfAverages(int[] A, int K) {
        int n = A.length;
        double[] prefixSum = new double[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + A[i];
        }

        double[][] dp = new double[K + 1][n + 1];
        for (int k = 1; k <= K; k++) {
            for (int i = k; i <= n; i++) {
                for (int j = k - 1; j < i; j++) {
                    dp[k][i] = Math.max(dp[k][i], dp[k - 1][j] + (prefixSum[i] - prefixSum[j]) / (i - j));
                }
            }
        }

        return dp[K][n];
    }
}