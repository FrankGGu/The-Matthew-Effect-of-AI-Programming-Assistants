class Solution {
    public int[][] generateMatrix(int n) {
        int[][] matrix = new int[n][n];

        int top = 0;
        int bottom = n - 1;
        int left = 0;
        int right = n - 1;

        int currentNumber = 1;

        while (top <= bottom && left <= right) {
            // Traverse right
            for (int c = left; c <= right; c++) {
                matrix[top][c] = currentNumber++;
            }
            top++;

            // Traverse down
            for (int r = top; r <= bottom; r++) {
                matrix[r][right] = currentNumber++;
            }
            right--;

            // Traverse left
            if (top <= bottom) {
                for (int c = right; c >= left; c--) {
                    matrix[bottom][c] = currentNumber++;
                }
                bottom--;
            }

            // Traverse up
            if (left <= right) {
                for (int r = bottom; r >= top; r--) {
                    matrix[r][left] = currentNumber++;
                }
                left++;
            }
        }

        return matrix;
    }
}