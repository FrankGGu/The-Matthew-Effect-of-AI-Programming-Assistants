class Solution {
    public int surfaceArea(int[][] grid) {
        int area = 0;
        int n = grid.length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > 0) {
                    area += 2; // Top and bottom surfaces
                    area += grid[i][j]; // Front surface
                    if (i > 0) {
                        area -= Math.min(grid[i][j], grid[i - 1][j]);
                    } else {
                        area += grid[i][j];
                    }

                    area += grid[i][j]; // Back surface
                    if (i < n - 1) {
                        area -= Math.min(grid[i][j], grid[i + 1][j]);
                    } else {
                        area += grid[i][j];
                    }

                    area += grid[i][j]; // Left surface
                    if (j > 0) {
                        area -= Math.min(grid[i][j], grid[i][j - 1]);
                    } else {
                        area += grid[i][j];
                    }

                    area += grid[i][j]; // Right surface
                    if (j < n - 1) {
                        area -= Math.min(grid[i][j], grid[i][j + 1]);
                    } else {
                        area += grid[i][j];
                    }
                }
            }
        }

        return area;
    }
}