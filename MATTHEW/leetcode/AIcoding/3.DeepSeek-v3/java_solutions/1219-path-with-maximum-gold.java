class Solution {
    private int maxGold = 0;
    private int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int getMaximumGold(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] != 0) {
                    dfs(grid, i, j, 0);
                }
            }
        }
        return maxGold;
    }

    private void dfs(int[][] grid, int i, int j, int currentGold) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] == 0) {
            return;
        }

        int gold = grid[i][j];
        currentGold += gold;
        maxGold = Math.max(maxGold, currentGold);

        grid[i][j] = 0;

        for (int[] dir : directions) {
            int x = i + dir[0];
            int y = j + dir[1];
            dfs(grid, x, y, currentGold);
        }

        grid[i][j] = gold;
    }
}