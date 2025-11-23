class Solution {
    int R, C;
    boolean[][] visited;
    int[] dr = {-1, 1, 0, 0};
    int[] dc = {0, 0, -1, 1};

    private void dfs(int r, int c, int[][] currentGrid) {
        if (r < 0 || r >= R || c < 0 || c >= C || visited[r][c] || currentGrid[r][c] == 0) {
            return;
        }
        visited[r][c] = true;
        for (int i = 0; i < 4; i++) {
            dfs(r + dr[i], c + dc[i], currentGrid);
        }
    }

    private int countConnectedComponents(int[][] currentGrid) {
        R = currentGrid.length;
        C = currentGrid[0].length;
        visited = new boolean[R][C];
        int components = 0;

        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                if (currentGrid[r][c] == 1 && !visited[r][c]) {
                    components++;
                    dfs(r, c, currentGrid);
                }
            }
        }
        return components;
    }

    public int minDays(int[][] grid) {
        R = grid.length;
        C = grid[0].length;

        int initialComponents = countConnectedComponents(grid);
        if (initialComponents != 1) {
            return 0;
        }

        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                if (grid[r][c] == 1) {
                    grid[r][c] = 0;
                    int componentsAfterRemoval = countConnectedComponents(grid);
                    grid[r][c] = 1;

                    if (componentsAfterRemoval != 1) {
                        return 1;
                    }
                }
            }
        }

        return 2;
    }
}