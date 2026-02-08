public class Solution {
    public int surfaceArea(int[][] grid) {
        int area = 0;
        int rows = grid.length;
        int cols = grid[0].length;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] > 0) {
                    area += 2;
                    if (i > 0) area += Math.max(0, grid[i][j] - grid[i-1][j]);
                    else area += grid[i][j];
                    if (i < rows - 1) area += Math.max(0, grid[i][j] - grid[i+1][j]);
                    else area += grid[i][j];
                    if (j > 0) area += Math.max(0, grid[i][j] - grid[i][j-1]);
                    else area += grid[i][j];
                    if (j < cols - 1) area += Math.max(0, grid[i][j] - grid[i][j+1]);
                    else area += grid[i][j];
                }
            }
        }
        return area;
    }
}