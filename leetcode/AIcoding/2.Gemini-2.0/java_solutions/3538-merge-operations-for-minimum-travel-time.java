import java.util.Arrays;

class Solution {
    public double getMinCost(int[] positions, int[] costs) {
        int n = positions.length;
        int[][] dp = new int[n][n];
        double[][] sum = new double[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int[] subPositions = Arrays.copyOfRange(positions, i, j + 1);
                int[] subCosts = Arrays.copyOfRange(costs, i, j + 1);
                Arrays.sort(subPositions);
                double median = subPositions.length % 2 == 0 ? (double)(subPositions[subPositions.length / 2 - 1] + subPositions[subPositions.length / 2]) / 2 : subPositions[subPositions.length / 2];

                double currentSum = 0;
                for(int k = 0; k < subPositions.length; k++){
                    currentSum += Math.abs(subPositions[k] - median) * subCosts[k];
                }
                sum[i][j] = currentSum;
            }
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                dp[i][j] = Integer.MAX_VALUE;
                for (int k = i; k < j; k++) {
                    dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k + 1][j]);
                }
                dp[i][j] += sum[i][j];
            }
        }

        return dp[0][n - 1];
    }
}