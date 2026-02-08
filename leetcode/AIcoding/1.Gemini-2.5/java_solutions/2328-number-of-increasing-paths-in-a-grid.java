class Solution {
    int m, n;
    int[][] grid;
    int[][] memo;
    int MOD = 1_000_000_007;
    int[] dr = {-1, 1, 0, 0};
    int[] dc = {0, 0, -1, 1};

    public int countPaths(int[][] grid) {
        this.grid = grid;
        m = grid.length;
        n = grid[0].length;
        memo = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                memo[i][j] = -1;
            }
        }

        int totalPaths = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                totalPaths = (totalPaths + dfs(i, j)) % MOD;
            }
        }

        return totalPaths;
    }

    private int dfs(int r, int c) {
        if (memo[r][c] != -1) {
            return memo[r][c];
        }

        int count = 1;

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] > grid[r][c]) {
                count = (count + dfs(nr, nc)) % MOD;
            }
        }

        memo[r][c] = count;
        return count;
    }
}