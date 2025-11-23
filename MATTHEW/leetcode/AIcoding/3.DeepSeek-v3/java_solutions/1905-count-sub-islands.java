class Solution {
    public int countSubIslands(int[][] grid1, int[][] grid2) {
        int m = grid1.length;
        int n = grid1[0].length;
        int count = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid2[i][j] == 1) {
                    if (dfs(grid1, grid2, i, j, m, n)) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    private boolean dfs(int[][] grid1, int[][] grid2, int i, int j, int m, int n) {
        if (i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] == 0) {
            return true;
        }

        boolean res = true;
        if (grid1[i][j] != 1) {
            res = false;
        }

        grid2[i][j] = 0;

        boolean up = dfs(grid1, grid2, i - 1, j, m, n);
        boolean down = dfs(grid1, grid2, i + 1, j, m, n);
        boolean left = dfs(grid1, grid2, i, j - 1, m, n);
        boolean right = dfs(grid1, grid2, i, j + 1, m, n);

        return res && up && down && left && right;
    }
}