class Solution {
    public int getMaximumGold(int[][] grid) {
        int maxGold = 0;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                maxGold = Math.max(maxGold, dfs(grid, i, j));
            }
        }
        return maxGold;
    }

    private int dfs(int[][] grid, int x, int y) {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || grid[x][y] == 0) {
            return 0;
        }
        int gold = grid[x][y];
        grid[x][y] = 0;
        int maxGold = Math.max(Math.max(dfs(grid, x + 1, y), dfs(grid, x - 1, y)),
                                Math.max(dfs(grid, x, y + 1), dfs(grid, x, y - 1)));
        grid[x][y] = gold;
        return gold + maxGold;
    }
}