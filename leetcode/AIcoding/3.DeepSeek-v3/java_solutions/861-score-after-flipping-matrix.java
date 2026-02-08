class Solution {
    public int matrixScore(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int res = m * (1 << (n - 1));

        for (int j = 1; j < n; j++) {
            int count = 0;
            for (int i = 0; i < m; i++) {
                if (grid[i][0] == 1) {
                    count += grid[i][j];
                } else {
                    count += (1 - grid[i][j]);
                }
            }
            res += Math.max(count, m - count) * (1 << (n - 1 - j));
        }

        return res;
    }
}