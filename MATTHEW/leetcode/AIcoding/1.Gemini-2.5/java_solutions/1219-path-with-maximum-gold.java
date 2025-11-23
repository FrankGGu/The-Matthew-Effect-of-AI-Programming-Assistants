class Solution {
    int maxGold = 0;
    int[][] grid;
    int m, n;
    int[] dr = {-1, 1, 0, 0}; // Row changes for up, down, left, right
    int[] dc = {0, 0, -1, 1}; // Col changes for up, down, left, right

    public int getMaximumGold(int[][] grid) {
        this.grid = grid;
        this.m = grid.length;
        this.n = grid[0].length;

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (grid[r][c] > 0) {
                    dfs(r, c, 0);
                }
            }
        }
        return maxGold;
    }

    private void dfs(int r, int c, int currentGold) {
        currentGold += grid[r][c];
        maxGold = Math.max(maxGold, currentGold);

        int originalGold = grid[r][c];
        grid[r][c] = 0; // Mark as visited

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] > 0) {
                dfs(nr, nc, currentGold);
            }
        }

        grid[r][c] = originalGold; // Backtrack: restore original value
    }
}