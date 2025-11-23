class Solution {
    public long maximumScore(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        long maxScore = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                maxScore = Math.max(maxScore, dfs(grid, i, j, new boolean[m][n]));
            }
        }

        return maxScore;
    }

    private long dfs(int[][] grid, int x, int y, boolean[][] visited) {
        int m = grid.length, n = grid[0].length;
        if (x < 0 || x >= m || y < 0 || y >= n || visited[x][y]) return 0;

        visited[x][y] = true;
        long score = grid[x][y];

        long maxNeigh = 0;
        for (int dx = -1; dx <= 1; dx++) {
            for (int dy = -1; dy <= 1; dy++) {
                if (Math.abs(dx) + Math.abs(dy) == 1) {
                    maxNeigh = Math.max(maxNeigh, dfs(grid, x + dx, y + dy, visited));
                }
            }
        }

        visited[x][y] = false;
        return score + maxNeigh;
    }
}