class Solution {
    public int[][] spiralMatrix(int m, int n, List<Integer> values) {
        int[][] matrix = new int[m][n];
        int top = 0, bottom = m - 1, left = 0, right = n - 1;
        int index = 0;

        while (top <= bottom && left <= right) {
            for (int i = left; i <= right && index < values.size(); i++) {
                matrix[top][i] = values.get(index++);
            }
            top++;
            for (int i = top; i <= bottom && index < values.size(); i++) {
                matrix[i][right] = values.get(index++);
            }
            right--;
            for (int i = right; i >= left && top <= bottom && index < values.size(); i--) {
                matrix[bottom][i] = values.get(index++);
            }
            bottom--;
            for (int i = bottom; i >= top && left <= right && index < values.size(); i--) {
                matrix[i][left] = values.get(index++);
            }
            left++;
        }

        return matrix;
    }
}