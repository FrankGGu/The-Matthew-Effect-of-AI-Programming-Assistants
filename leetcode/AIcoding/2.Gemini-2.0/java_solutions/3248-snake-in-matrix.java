public class SnakeInMatrix {

    public int[] findSnake(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return new int[0];
        }

        int rows = matrix.length;
        int cols = matrix[0].length;
        int[] result = new int[rows * cols];
        int index = 0;
        boolean leftToRight = true;

        for (int i = 0; i < rows; i++) {
            if (leftToRight) {
                for (int j = 0; j < cols; j++) {
                    result[index++] = matrix[i][j];
                }
            } else {
                for (int j = cols - 1; j >= 0; j--) {
                    result[index++] = matrix[i][j];
                }
            }
            leftToRight = !leftToRight;
        }

        return result;
    }