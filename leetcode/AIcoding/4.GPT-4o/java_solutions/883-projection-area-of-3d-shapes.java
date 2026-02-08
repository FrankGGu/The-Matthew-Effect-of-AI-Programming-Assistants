class Solution {
    public int projectionArea(int[][] grid) {
        int xy = 0, xz = 0, yz = 0;
        int n = grid.length, m = grid[0].length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] > 0) xy++;
            }
        }

        for (int i = 0; i < n; i++) {
            int max = 0;
            for (int j = 0; j < m; j++) {
                max = Math.max(max, grid[i][j]);
            }
            xz += max;
        }

        for (int j = 0; j < m; j++) {
            int max = 0;
            for (int i = 0; i < n; i++) {
                max = Math.max(max, grid[i][j]);
            }
            yz += max;
        }

        return xy + xz + yz;
    }
}