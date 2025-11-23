class Solution {
    public int minFallingPathSum(int[][] A) {
        int n = A.length;
        if (n == 0) return 0;

        int[][] dp = new int[n][n];
        System.arraycopy(A[0], 0, dp[0], 0, n);

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int minPrevRow = Integer.MAX_VALUE;
                for (int k = 0; k < n; k++) {
                    if (k != j) {
                        minPrevRow = Math.min(minPrevRow, dp[i - 1][k]);
                    }
                }
                dp[i][j] = A[i][j] + minPrevRow;
            }
        }

        int minPathSum = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            minPathSum = Math.min(minPathSum, dp[n - 1][j]);
        }

        return minPathSum;
    }
}