class Solution {
    public int[][] rotateGrid(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int layers = Math.min(m, n) / 2;

        for (int layer = 0; layer < layers; layer++) {
            int rows = m - 2 * layer;
            int cols = n - 2 * layer;
            int perimeter = 2 * rows + 2 * cols - 4;
            int rotations = k % perimeter;

            for (int r = 0; r < rotations; r++) {
                int temp = grid[layer][layer];

                // Move left to right on top
                for (int j = layer; j < n - layer - 1; j++) {
                    grid[layer][j] = grid[layer][j + 1];
                }

                // Move top to bottom on right
                for (int i = layer; i < m - layer - 1; i++) {
                    grid[i][n - layer - 1] = grid[i + 1][n - layer - 1];
                }

                // Move right to left on bottom
                for (int j = n - layer - 1; j > layer; j--) {
                    grid[m - layer - 1][j] = grid[m - layer - 1][j - 1];
                }

                // Move bottom to top on left
                for (int i = m - layer - 1; i > layer + 1; i--) {
                    grid[i][layer] = grid[i - 1][layer];
                }

                grid[layer + 1][layer] = temp;
            }
        }

        return grid;
    }
}