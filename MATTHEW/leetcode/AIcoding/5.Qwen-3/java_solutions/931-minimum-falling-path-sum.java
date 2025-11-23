public class Solution {
    public int minFallingPathSum(int[][] grid) {
        int n = grid.length;
        for (int i = 1; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int min = Integer.MAX_VALUE;
                for (int k = 0; k < n; k++) {
                    if (k != j) {
                        min = Math.min(min, grid[i - 1][k]);
                    }
                }
                grid[i][j] += min;
            }
        }
        int result = Integer.MAX_VALUE;
        for (int val : grid[n - 1]) {
            result = Math.min(result, val);
        }
        return result;
    }
}