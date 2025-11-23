class Solution {
    public int minFallingPathSum(int[][] matrix) {
        int n = matrix.length;

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int minPrev = matrix[i - 1][j];

                if (j > 0) {
                    minPrev = Math.min(minPrev, matrix[i - 1][j - 1]);
                }
                if (j < n - 1) {
                    minPrev = Math.min(minPrev, matrix[i - 1][j + 1]);
                }

                matrix[i][j] += minPrev;
            }
        }

        int minPathSum = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            minPathSum = Math.min(minPathSum, matrix[n - 1][j]);
        }

        return minPathSum;
    }
}