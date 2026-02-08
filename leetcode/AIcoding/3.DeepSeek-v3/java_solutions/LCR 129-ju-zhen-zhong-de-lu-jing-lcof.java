class Solution {
    public boolean wordPuzzle(char[][] grid, String target) {
        if (grid == null || grid.length == 0 || grid[0].length == 0 || target == null || target.length() == 0) {
            return false;
        }
        int m = grid.length;
        int n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == target.charAt(0)) {
                    if (dfs(grid, i, j, target, 0, visited)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

    private boolean dfs(char[][] grid, int i, int j, String target, int index, boolean[][] visited) {
        if (index == target.length()) {
            return true;
        }
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || visited[i][j] || grid[i][j] != target.charAt(index)) {
            return false;
        }
        visited[i][j] = true;
        boolean found = dfs(grid, i + 1, j, target, index + 1, visited) ||
                        dfs(grid, i - 1, j, target, index + 1, visited) ||
                        dfs(grid, i, j + 1, target, index + 1, visited) ||
                        dfs(grid, i, j - 1, target, index + 1, visited);
        visited[i][j] = false;
        return found;
    }
}