class Solution {
    public int minFallingPathSum(int[][] matrix) {
        int n = matrix.length;
        if (n == 1) return matrix[0][0];

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int min = matrix[i-1][j];
                if (j > 0) min = Math.min(min, matrix[i-1][j-1]);
                if (j < n-1) min = Math.min(min, matrix[i-1][j+1]);
                matrix[i][j] += min;
            }
        }

        int res = Integer.MAX_VALUE;
        for (int num : matrix[n-1]) {
            res = Math.min(res, num);
        }
        return res;
    }
}