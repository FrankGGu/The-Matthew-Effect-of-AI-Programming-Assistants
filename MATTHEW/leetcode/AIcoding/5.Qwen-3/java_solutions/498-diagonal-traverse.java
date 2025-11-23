public class Solution {
    public int[] findDiagonalOrder(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return new int[0];
        }

        int rows = matrix.length;
        int cols = matrix[0].length;
        int[] result = new int[rows * cols];
        int index = 0;
        boolean up = true;

        for (int i = 0; i < rows + cols - 1; i++) {
            if (up) {
                int r = i < rows ? i : rows - 1;
                int c = i < rows ? 0 : i - rows + 1;
                while (r >= 0 && c < cols) {
                    result[index++] = matrix[r][c];
                    r--;
                    c++;
                }
            } else {
                int c = i < cols ? i : cols - 1;
                int r = i < cols ? 0 : i - cols + 1;
                while (r < rows && c >= 0) {
                    result[index++] = matrix[r][c];
                    r++;
                    c--;
                }
            }
            up = !up;
        }

        return result;
    }
}