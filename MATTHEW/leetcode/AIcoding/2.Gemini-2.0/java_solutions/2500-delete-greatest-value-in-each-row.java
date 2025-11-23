import java.util.Arrays;

class Solution {
    public int deleteGreatestValue(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int sum = 0;

        for (int i = 0; i < m; i++) {
            Arrays.sort(grid[i]);
        }

        for (int j = 0; j < n; j++) {
            int maxVal = 0;
            for (int i = 0; i < m; i++) {
                maxVal = Math.max(maxVal, grid[i][j]);
            }
            sum += maxVal;
        }

        return sum;
    }
}