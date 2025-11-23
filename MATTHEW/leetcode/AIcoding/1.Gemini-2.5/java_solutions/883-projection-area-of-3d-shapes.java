class Solution {
    public int projectionArea(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int totalArea = 0;

        // Calculate XY-plane area (top view) and XZ-plane area (side view from Y-axis)
        for (int i = 0; i < n; i++) {
            int maxRowHeight = 0;
            for (int j = 0; j < m; j++) {
                // For XY-plane: if grid[i][j] > 0, there's a cube, so add 1 to area
                if (grid[i][j] > 0) {
                    totalArea++;
                }
                // For XZ-plane: find the maximum height in the current row
                maxRowHeight = Math.max(maxRowHeight, grid[i][j]);
            }
            // Add the maximum height of the current row to totalArea for XZ-plane
            totalArea += maxRowHeight;
        }

        // Calculate YZ-plane area (front view from X-axis)
        for (int j = 0; j < m; j++) {
            int maxColHeight = 0;
            for (int i = 0; i < n; i++) {
                // For YZ-plane: find the maximum height in the current column
                maxColHeight = Math.max(maxColHeight, grid[i][j]);
            }
            // Add the maximum height of the current column to totalArea for YZ-plane
            totalArea += maxColHeight;
        }

        return totalArea;
    }
}