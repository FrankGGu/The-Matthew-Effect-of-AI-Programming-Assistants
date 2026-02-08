import java.util.Arrays;

class Solution {
    public int minArea(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int minX = n, maxX = -1, minY = m, maxY = -1;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    minX = Math.min(minX, j);
                    maxX = Math.max(maxX, j);
                    minY = Math.min(minY, i);
                    maxY = Math.max(maxY, i);
                }
            }
        }
        if (maxX == -1) return 0;
        return (maxX - minX + 1) * (maxY - minY + 1);
    }
}