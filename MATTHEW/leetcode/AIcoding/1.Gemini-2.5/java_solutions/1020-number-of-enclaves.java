class Solution {
    int rows;
    int cols;
    int[][] grid;

    public int numEnclaves(int[][] grid) {
        this.grid = grid;
        rows = grid.length;
        cols = grid[0].length;

        // DFS from all '1's on the boundary
        // First and last rows
        for (int j = 0; j < cols; j++) {
            if (grid[0][j] == 1) {
                dfs(0, j);
            }
            if (grid[rows - 1][j] == 1) {
                dfs(rows - 1, j);
            }
        }

        // First and last columns (excluding corners already covered by row loops)
        for (int i = 0; i < rows; i++) {
            if (grid[i][0] == 1) {
                dfs(i, 0);
            }
            if (grid[i][cols - 1] == 1) {
                dfs(i, cols - 1);
            }
        }

        // Count remaining '1's, these are the enclaves
        int enclaves = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    enclaves++;
                }
            }
        }

        return enclaves;
    }

    private void dfs(int r, int c) {
        // Base cases: out of bounds or current cell is water (0)
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0) {
            return;
        }

        // Mark the current land cell as visited by changing it to 0
        // This effectively "removes" it from being counted as an enclave
        grid[r][c] = 0;

        // Explore all four neighbors
        dfs(r + 1, c); // Down
        dfs(r - 1, c); // Up
        dfs(r, c + 1); // Right
        dfs(r, c - 1); // Left
    }
}