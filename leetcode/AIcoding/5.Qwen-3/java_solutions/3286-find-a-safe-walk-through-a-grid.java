public class Solution {
    public boolean isSafeWalk(int[][] grid, int x, int y) {
        int rows = grid.length;
        int cols = grid[0].length;
        boolean[][] visited = new boolean[rows][cols];
        return dfs(grid, x, y, visited, 0);
    }

    private boolean dfs(int[][] grid, int x, int y, boolean[][] visited, int steps) {
        if (x < 0 || y < 0 || x >= grid.length || y >= grid[0].length || visited[x][y] || grid[x][y] == 1) {
            return false;
        }
        if (x == grid.length - 1 && y == grid[0].length - 1) {
            return steps + 1 == grid.length + grid[0].length - 1;
        }
        visited[x][y] = true;
        boolean res = dfs(grid, x + 1, y, visited, steps + 1) ||
                      dfs(grid, x - 1, y, visited, steps + 1) ||
                      dfs(grid, x, y + 1, visited, steps + 1) ||
                      dfs(grid, x, y - 1, visited, steps + 1);
        visited[x][y] = false;
        return res;
    }
}