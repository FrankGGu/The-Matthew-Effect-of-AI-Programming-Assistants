class Solution {
    public boolean isPossibleToCutPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        if (!dfs(grid, visited, 0, 0, m, n)) {
            return true;
        }
        visited = new boolean[m][n];
        return !dfs(grid, visited, 0, 0, m, n);
    }

    private boolean dfs(int[][] grid, boolean[][] visited, int i, int j, int m, int n) {
        if (i == m - 1 && j == n - 1) {
            return true;
        }
        if (i >= m || j >= n || grid[i][j] == 0 || visited[i][j]) {
            return false;
        }
        visited[i][j] = true;
        return dfs(grid, visited, i + 1, j, m, n) || dfs(grid, visited, i, j + 1, m, n);
    }
}