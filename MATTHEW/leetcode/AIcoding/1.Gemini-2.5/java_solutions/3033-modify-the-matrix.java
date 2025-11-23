class Solution {
    public int[][] modifyMatrix(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;

        int[] colMaxes = new int[n];

        for (int j = 0; j < n; j++) {
            int currentMax = 0;
            for (int i = 0; i < m; i++) {
                currentMax = Math.max(currentMax, matrix[i][j]);
            }
            colMaxes[j] = currentMax;
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] == -1) {
                    matrix[i][j] = colMaxes[j];
                }
            }
        }

        return matrix;
    }
}