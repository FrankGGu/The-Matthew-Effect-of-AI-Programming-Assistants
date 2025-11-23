public class Solution {
    public int numSpecial(int[][] matrix) {
        int rows = matrix.length;
        int cols = matrix[0].length;
        int[] rowSum = new int[rows];
        int[] colSum = new int[cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                rowSum[i] += matrix[i][j];
                colSum[j] += matrix[i][j];
            }
        }

        int count = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (matrix[i][j] == 1 && rowSum[i] == 1 && colSum[j] == 1) {
                    count++;
                }
            }
        }

        return count;
    }
}