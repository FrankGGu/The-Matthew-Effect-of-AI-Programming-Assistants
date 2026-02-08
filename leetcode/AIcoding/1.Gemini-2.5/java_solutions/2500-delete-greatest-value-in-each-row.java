import java.util.Arrays;

class Solution {
    public int deleteGreatestValue(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        for (int i = 0; i < m; i++) {
            Arrays.sort(grid[i]);
        }

        int totalSum = 0;
        for (int j = 0; j < n; j++) {
            int currentMaxSum = 0;
            for (int i = 0; i < m; i++) {
                currentMaxSum = Math.max(currentMaxSum, grid[i][j]);
            }
            totalSum += currentMaxSum;
        }

        return totalSum;
    }
}