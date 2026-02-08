class Solution {
    private int rows, cols;
    private int[][] grid;

    public int minDays(int[][] grid) {
        this.grid = grid;
        rows = grid.length;
        cols = grid[0].length;

        int islands = countIslands();

        if (islands == 0 || islands > 1) {
            return 0;
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    if (countIslands() != 1) {
                        return 1;
                    }
                    grid[i][j] = 1;
                }
            }
        }

        return 2;
    }

    private int countIslands() {
        int islands = 0;
        int[][] tempGrid = new int[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                tempGrid[i][j] = grid[i][j];
            }
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (tempGrid[i][j] == 1) {
                    islands++;
                    dfs(tempGrid, i, j);
                }
            }
        }

        return islands;
    }

    private void dfs(int[][] grid, int row, int col) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] == 0) {
            return;
        }

        grid[row][col] = 0;
        dfs(grid, row + 1, col);
        dfs(grid, row - 1, col);
        dfs(grid, row, col + 1);
        dfs(grid, row, col - 1);
    }
}