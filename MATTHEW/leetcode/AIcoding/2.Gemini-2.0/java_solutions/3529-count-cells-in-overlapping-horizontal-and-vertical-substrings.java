class Solution {
    public int countCells(int n, int m, int k, int r, int c) {
        int[][] grid = new int[n][m];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (Math.abs(i - r) <= k || Math.abs(j - c) <= k) {
                    grid[i][j] = 1;
                }
            }
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                count += grid[i][j];
            }
        }

        return count;
    }
}