class Solution {
    public int closedIsland(int[][] grid) {
        int count = 0;
        int m = grid.length, n = grid[0].length;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    if (dfs(grid, i, j)) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    private boolean dfs(int[][] grid, int x, int y) {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length) {
            return false;
        }
        if (grid[x][y] == 1) {
            return true;
        }
        grid[x][y] = 1;
        boolean up = dfs(grid, x - 1, y);
        boolean down = dfs(grid, x + 1, y);
        boolean left = dfs(grid, x, y - 1);
        boolean right = dfs(grid, x, y + 1);
        return up && down && left && right;
    }
}