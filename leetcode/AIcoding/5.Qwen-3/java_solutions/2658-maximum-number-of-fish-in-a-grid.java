public class Solution {
    public int fish(int[][] grid) {
        int maxFish = 0;
        boolean[][] visited = new boolean[grid.length][grid[0].length];

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (!visited[i][j] && grid[i][j] > 0) {
                    maxFish = Math.max(maxFish, dfs(grid, i, j, visited));
                }
            }
        }
        return maxFish;
    }

    private int dfs(int[][] grid, int i, int j, boolean[][] visited) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || visited[i][j] || grid[i][j] == 0) {
            return 0;
        }
        visited[i][j] = true;
        int sum = grid[i][j];
        sum += dfs(grid, i + 1, j, visited);
        sum += dfs(grid, i - 1, j, visited);
        sum += dfs(grid, i, j + 1, visited);
        sum += dfs(grid, i, j - 1, visited);
        return sum;
    }
}