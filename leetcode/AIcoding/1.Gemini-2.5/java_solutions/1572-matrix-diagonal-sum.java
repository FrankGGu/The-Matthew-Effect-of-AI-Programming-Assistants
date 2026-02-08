class Solution {
    public int diagonalSum(int[][] mat) {
        int n = mat.length;
        int sum = 0;

        for (int i = 0; i < n; i++) {
            // Primary diagonal
            sum += mat[i][i];
            // Secondary diagonal
            // Ensure it's not the same element as primary diagonal for odd n
            if (i != n - 1 - i) {
                sum += mat[i][n - 1 - i];
            }
        }

        return sum;
    }
}