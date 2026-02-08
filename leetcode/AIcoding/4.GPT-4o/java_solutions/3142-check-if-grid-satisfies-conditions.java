class Solution {
    public boolean checkGrid(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        boolean[] row = new boolean[n];
        boolean[] col = new boolean[m];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] != 1) {
                    return false;
                }
                if (row[i] || col[j]) {
                    return false;
                }
                row[i] = true;
                col[j] = true;
            }
        }
        return true;
    }
}