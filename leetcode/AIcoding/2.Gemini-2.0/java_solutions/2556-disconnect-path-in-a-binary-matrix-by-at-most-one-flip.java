class Solution {
    public boolean isPossibleToCutPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        if (m == 1 && n == 1) return false;

        grid[0][0] = 0;
        boolean[][] visited = new boolean[m][n];
        dfs(grid, 0, 0, visited);

        if (!visited[m - 1][n - 1]) return true;

        grid[0][0] = 1;
        grid[m - 1][n - 1] = 0;
        visited = new boolean[m][n];
        dfs(grid, 0, 0, visited);

        return !visited[m - 1][n - 1];
    }

    private void dfs(int[][] grid, int i, int j, boolean[][] visited) {
        int m = grid.length;
        int n = grid[0].length;

        if (i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 0 || visited[i][j]) {
            return;
        }

        visited[i][j] = true;

        dfs(grid, i + 1, j, visited);
        dfs(grid, i, j + 1, visited);
    }
}