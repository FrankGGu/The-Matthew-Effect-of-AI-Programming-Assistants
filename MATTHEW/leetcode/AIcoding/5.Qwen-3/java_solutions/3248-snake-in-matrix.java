public class Solution {
    public int[] snakeInMatrix(int[][] matrix) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int[] result = new int[rows * cols];
        int index = 0;

        for (int i = 0; i < rows; i++) {
            if (i % 2 == 0) {
                for (int j = 0; j < cols; j++) {
                    result[index++] = matrix[i][j];
                }
            } else {
                for (int j = cols - 1; j >= 0; j--) {
                    result[index++] = matrix[i][j];
                }
            }
        }

        return result;
    }
}