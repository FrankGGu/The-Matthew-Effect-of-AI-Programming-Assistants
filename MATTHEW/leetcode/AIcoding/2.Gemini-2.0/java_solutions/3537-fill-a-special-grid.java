class Solution {
    public int[][] fillGrid(int n, int m, int k) {
        int[][] grid = new int[n][m];
        int val = 1;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (k > 0) {
                    grid[i][j] = val;
                    k--;
                } else {
                    grid[i][j] = -val;
                }
                val = -val;
            }
            if (m % 2 == 0) {
                val = -val;
            }
        }
        return grid;
    }
}