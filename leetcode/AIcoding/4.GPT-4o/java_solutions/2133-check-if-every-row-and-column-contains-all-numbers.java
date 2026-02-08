class Solution {
    public boolean checkValid(int[][] matrix) {
        int n = matrix.length;
        boolean[] seen;

        for (int i = 0; i < n; i++) {
            seen = new boolean[n];
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] < 1 || matrix[i][j] > n || seen[matrix[i][j] - 1]) {
                    return false;
                }
                seen[matrix[i][j] - 1] = true;
            }
        }

        for (int j = 0; j < n; j++) {
            seen = new boolean[n];
            for (int i = 0; i < n; i++) {
                if (matrix[i][j] < 1 || matrix[i][j] > n || seen[matrix[i][j] - 1]) {
                    return false;
                }
                seen[matrix[i][j] - 1] = true;
            }
        }

        return true;
    }
}