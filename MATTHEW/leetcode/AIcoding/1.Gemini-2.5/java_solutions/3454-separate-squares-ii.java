class Solution {
    private int[][] grid;
    private int rows;
    private int cols;

    public boolean separateSquaresII(int[][] grid) {
        this.grid = grid;
        this.rows = grid.length;
        if (this.rows == 0) {
            return false;
        }
        this.cols = grid[0].length;
        if (this.cols == 0) {
            return false;
        }

        int componentCount = 0;

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (grid[r][c] == 1) {
                    componentCount++;
                    if (componentCount > 2) {
                        return false;
                    }
                    dfs(r, c);
                }
            }
        }
        return componentCount == 2;
    }

    private void dfs(int r, int c) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0) {
            return;
        }
        grid[r][c] = 0;
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }
}