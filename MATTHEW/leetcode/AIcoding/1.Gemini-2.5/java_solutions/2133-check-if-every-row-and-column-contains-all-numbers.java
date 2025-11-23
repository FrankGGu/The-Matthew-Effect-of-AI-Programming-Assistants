class Solution {
    public boolean checkValid(int[][] matrix) {
        int n = matrix.length;

        // Check each row
        for (int i = 0; i < n; i++) {
            boolean[] seen = new boolean[n + 1];
            for (int j = 0; j < n; j++) {
                int num = matrix[i][j];
                if (num < 1 || num > n || seen[num]) {
                    return false;
                }
                seen[num] = true;
            }
        }

        // Check each column
        for (int j = 0; j < n; j++) {
            boolean[] seen = new boolean[n + 1];
            for (int i = 0; i < n; i++) {
                int num = matrix[i][j];
                if (num < 1 || num > n || seen[num]) {
                    return false;
                }
                seen[num] = true;
            }
        }

        return true;
    }
}