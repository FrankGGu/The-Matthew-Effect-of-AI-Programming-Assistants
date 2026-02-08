class Solution {
    public boolean canDisconnect(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        return dfs(grid, 0, 0, m - 1, n - 1, visited, false);
    }

    private boolean dfs(int[][] grid, int x, int y, int destX, int destY, boolean[][] visited, boolean flipped) {
        if (x < 0 || x >= grid.length || y < 0 || y >= grid[0].length || visited[x][y]) {
            return false;
        }
        if (x == destX && y == destY) {
            return true;
        }
        visited[x][y] = true;
        if (grid[x][y] == 0) {
            if (flipped) {
                visited[x][y] = false;
                return false;
            }
            boolean res = dfs(grid, x + 1, y, destX, destY, visited, true) ||
                          dfs(grid, x - 1, y, destX, destY, visited, true) ||
                          dfs(grid, x, y + 1, destX, destY, visited, true) ||
                          dfs(grid, x, y - 1, destX, destY, visited, true);
            visited[x][y] = false;
            return res;
        } else {
            boolean res = dfs(grid, x + 1, y, destX, destY, visited, flipped) ||
                          dfs(grid, x - 1, y, destX, destY, visited, flipped) ||
                          dfs(grid, x, y + 1, destX, destY, visited, flipped) ||
                          dfs(grid, x, y - 1, destX, destY, visited, flipped);
            visited[x][y] = false;
            return res;
        }
    }
}