class Solution {
    public int projectionArea(int[][] grid) {
        int n = grid.length;
        int xyArea = 0;
        int xzArea = 0;
        int yzArea = 0;

        for (int i = 0; i < n; i++) {
            int xzMax = 0;
            int yzMax = 0;
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > 0) {
                    xyArea++;
                }
                xzMax = Math.max(xzMax, grid[i][j]);
                yzMax = Math.max(yzMax, grid[j][i]);
            }
            xzArea += xzMax;
            yzArea += yzMax;
        }

        return xyArea + xzArea + yzArea;
    }
}