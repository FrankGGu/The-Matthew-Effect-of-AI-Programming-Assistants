class Solution {
    public int minFlips(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int flips = 0;

        for (int i = 0; i < n / 2; i++) {
            for (int j = 0; j < m / 2; j++) {
                int count = grid[i][j] + grid[n - 1 - i][j] + grid[i][m - 1 - j] + grid[n - 1 - i][m - 1 - j];
                flips += Math.min(count, 4 - count);
            }
        }

        if (n % 2 == 1) {
            for (int j = 0; j < m / 2; j++) {
                flips += Math.min(grid[n / 2][j], 1 - grid[n / 2][j]);
            }
        }

        if (m % 2 == 1) {
            for (int i = 0; i < n / 2; i++) {
                flips += Math.min(grid[i][m / 2], 1 - grid[i][m / 2]);
            }
        }

        return flips;
    }
}