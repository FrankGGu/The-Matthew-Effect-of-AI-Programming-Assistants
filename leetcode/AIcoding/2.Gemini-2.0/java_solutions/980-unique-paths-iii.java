class Solution {
    int ans = 0;
    int empty = 1;

    public int uniquePathsIII(int[][] grid) {
        int sx = 0, sy = 0;
        for (int i = 0; i < grid.length; ++i) {
            for (int j = 0; j < grid[0].length; ++j) {
                if (grid[i][j] == 0)
                    empty++;
                else if (grid[i][j] == 1) {
                    sx = i;
                    sy = j;
                }
            }
        }

        dfs(grid, sx, sy);
        return ans;
    }

    public void dfs(int[][] grid, int x, int y) {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || grid[x][y] == -1)
            return;

        if (grid[x][y] == 2) {
            if (empty == 0)
                ans++;
            return;
        }

        grid[x][y] = -1;
        empty--;

        dfs(grid, x + 1, y);
        dfs(grid, x - 1, y);
        dfs(grid, x, y + 1);
        dfs(grid, x, y - 1);

        grid[x][y] = 0;
        empty++;
    }
}