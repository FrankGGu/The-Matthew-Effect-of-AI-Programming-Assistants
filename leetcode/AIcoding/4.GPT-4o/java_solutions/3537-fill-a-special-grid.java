class Solution {
    public int[][] fillGrid(int n) {
        int[][] grid = new int[n][n];
        int num = 1;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if ((i + j) % 2 == 0) {
                    grid[i][j] = num++;
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if ((i + j) % 2 == 1) {
                    grid[i][j] = num++;
                }
            }
        }

        return grid;
    }
}