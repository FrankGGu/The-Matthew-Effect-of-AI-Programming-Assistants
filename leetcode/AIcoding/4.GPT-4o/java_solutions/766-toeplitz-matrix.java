class Solution {
    public boolean isToeplitzMatrix(int[][] matrix) {
        int rows = matrix.length;
        int cols = matrix[0].length;

        for (int r = 0; r < rows; r++) {
            int row = r, col = 0;
            int value = matrix[r][0];
            while (row < rows && col < cols) {
                if (matrix[row][col] != value) {
                    return false;
                }
                row++;
                col++;
            }
        }

        for (int c = 1; c < cols; c++) {
            int row = 0, col = c;
            int value = matrix[0][c];
            while (row < rows && col < cols) {
                if (matrix[row][col] != value) {
                    return false;
                }
                row++;
                col++;
            }
        }

        return true;
    }
}