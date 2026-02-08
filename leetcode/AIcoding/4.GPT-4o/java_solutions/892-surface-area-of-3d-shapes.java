class Solution {
    public int surfaceArea(int[][] grid) {
        int n = grid.length;
        int area = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > 0) {
                    area += 2; // top and bottom
                    area += grid[i][j] * 4; // all sides
                    if (i > 0) area -= Math.min(grid[i][j], grid[i - 1][j]) * 2; // front
                    if (j > 0) area -= Math.min(grid[i][j], grid[i][j - 1]) * 2; // left
                }
            }
        }

        return area;
    }
}