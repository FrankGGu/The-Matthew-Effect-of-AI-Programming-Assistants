class Solution {
    public int findMaxFish(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int maxFish = 0;
        boolean[][] visited = new boolean[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > 0 && !visited[i][j]) {
                    maxFish = Math.max(maxFish, dfs(grid, i, j, visited));
                }
            }
        }

        return maxFish;
    }

    private int dfs(int[][] grid, int i, int j, boolean[][] visited) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] == 0 || visited[i][j]) {
            return 0;
        }

        visited[i][j] = true;
        int fish = grid[i][j];

        fish += dfs(grid, i + 1, j, visited);
        fish += dfs(grid, i - 1, j, visited);
        fish += dfs(grid, i, j + 1, visited);
        fish += dfs(grid, i, j - 1, visited);

        return fish;
    }
}