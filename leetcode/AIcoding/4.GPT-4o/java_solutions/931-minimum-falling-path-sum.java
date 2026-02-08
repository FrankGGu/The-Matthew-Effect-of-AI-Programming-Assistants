class Solution {
    public int minFallingPathSum(int[][] matrix) {
        int n = matrix.length;
        for (int i = n - 2; i >= 0; i--) {
            for (int j = 0; j < n; j++) {
                int minBelow = matrix[i + 1][j];
                if (j > 0) minBelow = Math.min(minBelow, matrix[i + 1][j - 1]);
                if (j < n - 1) minBelow = Math.min(minBelow, matrix[i + 1][j + 1]);
                matrix[i][j] += minBelow;
            }
        }
        int minPathSum = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            minPathSum = Math.min(minPathSum, matrix[0][j]);
        }
        return minPathSum;
    }
}