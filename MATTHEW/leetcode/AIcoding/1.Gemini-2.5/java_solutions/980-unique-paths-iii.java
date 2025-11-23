class Solution {
    int R, C;
    int[][] grid;
    int targetVisitedCells;
    int paths = 0;

    public int uniquePathsIII(int[][] grid) {
        this.grid = grid;
        R = grid.length;
        C = grid[0].length;
        targetVisitedCells = 0;
        int startR = 0, startC = 0;

        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                if (grid[r][c] != -1) {
                    targetVisitedCells++;
                }
                if (grid[r][c] == 1) {
                    startR = r;
                    startC = c;
                }
            }
        }

        dfs(startR, startC, 1);
        return paths;
    }

    private void dfs(int r, int c, int visitedCount) {
        if (r < 0 || r >= R || c < 0 || c >= C || grid[r][c] == -1 || grid[r][c] == -2) {
            return;
        }

        if (grid[r][c] == 2) {
            if (visitedCount == targetVisitedCells) {
                paths++;
            }
            return;
        }

        int originalValue = grid[r][c];
        grid[r][c] = -2; 

        dfs(r + 1, c, visitedCount + 1);
        dfs(r - 1, c, visitedCount + 1);
        dfs(r, c + 1, visitedCount + 1);
        dfs(r, c - 1, visitedCount + 1);

        grid[r][c] = originalValue;
    }
}