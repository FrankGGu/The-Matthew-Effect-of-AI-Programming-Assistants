class Solution {
    public int[][] rotateGrid(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int layers = Math.min(m, n) / 2;

        for (int l = 0; l < layers; l++) {
            int perimeter = 2 * (m - 2 * l) + 2 * (n - 2 * l - 2);
            int rotations = k % perimeter;

            for (int r = 0; r < rotations; r++) {
                int temp = grid[l][l];

                for (int j = l; j < n - l - 1; j++) {
                    grid[l][j] = grid[l][j + 1];
                }

                for (int i = l; i < m - l - 1; i++) {
                    grid[i][n - l - 1] = grid[i + 1][n - l - 1];
                }

                for (int j = n - l - 1; j > l; j--) {
                    grid[m - l - 1][j] = grid[m - l - 1][j - 1];
                }

                for (int i = m - l - 1; i > l + 1; i--) {
                    grid[i][l] = grid[i - 1][l];
                }

                grid[l + 1][l] = temp;
            }
        }

        return grid;
    }
}