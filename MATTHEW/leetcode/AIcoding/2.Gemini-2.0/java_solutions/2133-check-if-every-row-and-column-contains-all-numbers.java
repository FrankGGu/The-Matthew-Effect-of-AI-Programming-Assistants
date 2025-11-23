class Solution {
    public boolean checkValid(int[][] matrix) {
        int n = matrix.length;
        for (int i = 0; i < n; i++) {
            boolean[] rowCheck = new boolean[n + 1];
            boolean[] colCheck = new boolean[n + 1];
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] < 1 || matrix[i][j] > n || rowCheck[matrix[i][j]]) return false;
                rowCheck[matrix[i][j]] = true;

                if (matrix[j][i] < 1 || matrix[j][i] > n || colCheck[matrix[j][i]]) return false;
                colCheck[matrix[j][i]] = true;
            }
        }
        return true;
    }
}