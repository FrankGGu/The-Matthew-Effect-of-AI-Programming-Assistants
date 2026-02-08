class Solution {
    public int oddCells(int n, int m, int[][] indices) {
        int[][] matrix = new int[n][m];
        for (int[] index : indices) {
            int r = index[0], c = index[1];
            for (int i = 0; i < m; i++) {
                matrix[r][i]++;
            }
            for (int i = 0; i < n; i++) {
                matrix[i][c]++;
            }
        }
        int count = 0;
        for (int[] row : matrix) {
            for (int val : row) {
                if (val % 2 != 0) {
                    count++;
                }
            }
        }
        return count;
    }
}