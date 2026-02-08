public class Solution {
    public int oddCells(int n, int m, int[][] indices) {
        int[][] matrix = new int[n][m];
        for (int[] index : indices) {
            int x = index[0];
            int y = index[1];
            for (int i = 0; i < n; i++) {
                matrix[i][y]++;
            }
            for (int j = 0; j < m; j++) {
                matrix[x][j]++;
            }
        }
        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (matrix[i][j] % 2 != 0) {
                    count++;
                }
            }
        }
        return count;
    }
}