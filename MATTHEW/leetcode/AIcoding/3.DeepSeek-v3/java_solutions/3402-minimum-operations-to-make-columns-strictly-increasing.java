class Solution {
    public int minOperations(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int res = 0;

        for (int j = 0; j < n; j++) {
            for (int i = 1; i < m; i++) {
                if (grid[i][j] <= grid[i - 1][j]) {
                    res += (grid[i - 1][j] - grid[i][j] + 1);
                    grid[i][j] = grid[i - 1][j] + 1;
                }
            }
        }

        return res;
    }
}