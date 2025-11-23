class Solution {
    public int numFishInGrid(int[][] grid) {
        int maxFish = 0;
        boolean[][] visited = new boolean[grid.length][grid[0].length];

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (!visited[i][j] && grid[i][j] > 0) {
                    maxFish = Math.max(maxFish, dfs(grid, visited, i, j));
                }
            }
        }

        return maxFish;
    }

    private int dfs(int[][] grid, boolean[][] visited, int i, int j) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || visited[i][j] || grid[i][j] == 0) {
            return 0;
        }

        visited[i][j] = true;
        int fishCount = grid[i][j];

        fishCount += dfs(grid, visited, i + 1, j);
        fishCount += dfs(grid, visited, i - 1, j);
        fishCount += dfs(grid, visited, i, j + 1);
        fishCount += dfs(grid, visited, i, j - 1);

        return fishCount;
    }
}