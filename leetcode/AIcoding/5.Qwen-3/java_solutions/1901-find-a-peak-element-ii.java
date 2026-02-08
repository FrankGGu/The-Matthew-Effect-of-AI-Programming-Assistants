public class Solution {
    public int findPeakElement(int[][] matrix) {
        int rows = matrix.length;
        int cols = matrix[0].length;

        int left = 0;
        int right = cols - 1;

        while (left <= right) {
            int midCol = left + (right - left) / 2;
            int maxRow = 0;

            for (int i = 1; i < rows; i++) {
                if (matrix[i][midCol] > matrix[maxRow][midCol]) {
                    maxRow = i;
                }
            }

            if (midCol == 0) {
                if (matrix[maxRow][midCol] > matrix[maxRow][midCol + 1]) {
                    return matrix[maxRow][midCol];
                } else {
                    left = midCol + 1;
                }
            } else if (midCol == cols - 1) {
                if (matrix[maxRow][midCol] > matrix[maxRow][midCol - 1]) {
                    return matrix[maxRow][midCol];
                } else {
                    right = midCol - 1;
                }
            } else {
                if (matrix[maxRow][midCol] > matrix[maxRow][midCol - 1] && matrix[maxRow][midCol] > matrix[maxRow][midCol + 1]) {
                    return matrix[maxRow][midCol];
                } else if (matrix[maxRow][midCol] < matrix[maxRow][midCol + 1]) {
                    left = midCol + 1;
                } else {
                    right = midCol - 1;
                }
            }
        }

        return -1;
    }
}