public class Solution {
    public int[][] generateMatrix(int n) {
        int[][] matrix = new int[n][n];
        int num = 1;
        int top = 0, bottom = n - 1, left = 0, right = n - 1;

        while (top <= bottom && left <= right) {
            for (int i = left; i <= right && top <= bottom; i++) {
                matrix[top][i] = num++;
            }
            top++;

            for (int i = top; i <= bottom && left <= right; i++) {
                matrix[i][right] = num++;
            }
            right--;

            for (int i = right; i >= left && top <= bottom; i--) {
                matrix[bottom][i] = num++;
            }
            bottom--;

            for (int i = bottom; i >= top && left <= right; i--) {
                matrix[i][left] = num++;
            }
            left++;
        }

        return matrix;
    }
}