class Solution {
    private static final int[][] DIRECTIONS = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public boolean containsCycle(char[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        boolean[][] visited = new boolean[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (!visited[i][j] && dfs(grid, i, j, -1, -1, grid[i][j], visited)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean dfs(char[][] grid, int i, int j, int pi, int pj, char target, boolean[][] visited) {
        if (i < 0 || i >= grid.length || j < 0 || j >= grid[0].length || grid[i][j] != target) {
            return false;
        }
        if (visited[i][j]) {
            return true;
        }
        visited[i][j] = true;
        for (int[] dir : DIRECTIONS) {
            int ni = i + dir[0];
            int nj = j + dir[1];
            if (ni == pi && nj == pj) {
                continue;
            }
            if (dfs(grid, ni, nj, i, j, target, visited)) {
                return true;
            }
        }
        return false;
    }
}