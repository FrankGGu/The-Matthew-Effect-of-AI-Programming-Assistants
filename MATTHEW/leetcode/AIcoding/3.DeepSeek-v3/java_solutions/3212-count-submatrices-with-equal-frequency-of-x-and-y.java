class Solution {
    public int countSubmatrices(int[][] grid, int x, int y) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] prefix = new int[m + 1][n + 1];
        int count = 0;

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                prefix[i][j] = prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1] + (grid[i - 1][j - 1] == x ? 1 : 0) - (grid[i - 1][j - 1] == y ? 1 : 0);
                if (prefix[i][j] == 0) {
                    count++;
                }
            }
        }

        return count;
    }
}