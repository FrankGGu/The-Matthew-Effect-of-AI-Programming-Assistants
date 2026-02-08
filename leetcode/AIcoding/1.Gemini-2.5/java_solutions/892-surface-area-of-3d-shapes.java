class Solution {
    public int surfaceArea(int[][] grid) {
        int N = grid.length;
        int totalArea = 0;

        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                int v = grid[i][j];

                if (v == 0) {
                    continue;
                }

                // Add top and bottom faces
                totalArea += 2;

                // Add all 4 side faces for current stack (if isolated)
                totalArea += 4 * v;

                // Subtract hidden areas due to neighbors
                // Overlap with North neighbor (grid[i-1][j])
                if (i > 0) {
                    totalArea -= 2 * Math.min(v, grid[i - 1][j]);
                }
                // Overlap with West neighbor (grid[i][j-1])
                if (j > 0) {
                    totalArea -= 2 * Math.min(v, grid[i][j - 1]);
                }
                // We only need to check North and West from current (i,j)
                // because the overlaps with South and East neighbors will be
                // handled when those neighbors are processed as (i-1,j) or (i,j-1) relative to current.
            }
        }
        return totalArea;
    }
}