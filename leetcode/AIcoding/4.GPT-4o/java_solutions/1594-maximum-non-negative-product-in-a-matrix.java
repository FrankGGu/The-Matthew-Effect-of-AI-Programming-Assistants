class Solution {
    public int maxProductPath(int[][] grid) {
        int mod = 1000000007;
        int m = grid.length, n = grid[0].length;
        long[][] maxProd = new long[m][n];
        long[][] minProd = new long[m][n];

        maxProd[0][0] = minProd[0][0] = grid[0][0];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (i == 0 && j == 0) continue;
                long max = Long.MIN_VALUE, min = Long.MAX_VALUE;
                if (i > 0) {
                    max = Math.max(max, maxProd[i - 1][j]);
                    min = Math.min(min, minProd[i - 1][j]);
                }
                if (j > 0) {
                    max = Math.max(max, maxProd[i][j - 1]);
                    min = Math.min(min, minProd[i][j - 1]);
                }
                if (grid[i][j] >= 0) {
                    maxProd[i][j] = Math.max(max * grid[i][j], grid[i][j]);
                    minProd[i][j] = Math.min(min * grid[i][j], grid[i][j]);
                } else {
                    maxProd[i][j] = Math.max(min * grid[i][j], grid[i][j]);
                    minProd[i][j] = Math.min(max * grid[i][j], grid[i][j]);
                }
            }
        }

        return maxProd[m - 1][n - 1] < 0 ? -1 : (int) (maxProd[m - 1][n - 1] % mod);
    }
}