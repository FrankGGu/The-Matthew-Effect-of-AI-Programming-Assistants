class Solution {
    public int maxSum(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int maxSum = 0;

        for (int r = 0; r <= m - 3; r++) {
            for (int c = 0; c <= n - 3; c++) {
                int currentSum = 0;
                // Top row
                currentSum += grid[r][c];
                currentSum += grid[r][c + 1];
                currentSum += grid[r][c + 2];
                // Middle element
                currentSum += grid[r + 1][c + 1];
                // Bottom row
                currentSum += grid[r + 2][c];
                currentSum += grid[r + 2][c + 1];
                currentSum += grid[r + 2][c + 2];

                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }
        }

        return maxSum;
    }
}