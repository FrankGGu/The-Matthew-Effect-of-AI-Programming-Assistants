class Solution {
    int m, n;
    int[] dr = {-1, 1, 0, 0};
    int[] dc = {0, 0, -1, 1};

    public int countSubIslands(int[][] grid1, int[][] grid2) {
        m = grid1.length;
        n = grid1[0].length;
        int count = 0;

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (grid2[r][c] == 1) {
                    if (dfs(grid1, grid2, r, c)) {
                        count++;
                    }
                }
            }
        }
        return count;
    }

    private boolean dfs(int[][] grid1, int[][] grid2, int r, int c) {
        if (r < 0 || r >= m || c < 0 || c >= n || grid2[r][c] == 0) {
            return true;
        }

        grid2[r][c] = 0;

        boolean currentCellInGrid1 = (grid1[r][c] == 1);

        boolean neighborsAreSubIslands = true;
        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            neighborsAreSubIslands = neighborsAreSubIslands && dfs(grid1, grid2, nr, nc);
        }

        return currentCellInGrid1 && neighborsAreSubIslands;
    }
}