class Solution {
    public int[][] modifyColumns(int[][] matrix) {
        int m = matrix.length, n = matrix[0].length;
        int[][] result = new int[m][n];

        for (int j = 0; j < n; j++) {
            int[] column = new int[m];
            for (int i = 0; i < m; i++) {
                column[i] = matrix[i][j];
            }
            Arrays.sort(column);
            for (int i = 0; i < m; i++) {
                result[i][j] = column[i];
            }
        }

        return result;
    }
}