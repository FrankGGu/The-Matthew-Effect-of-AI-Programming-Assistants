class Solution {
    public int[][] constructGrid(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int[][] result = new int[n][m];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                result[i][j] = grid[i][j];
            }
        }

        return result;
    }
}