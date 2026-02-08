class Solution {
    public int closedIsland(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int count = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 0) {
                    if (isClosedIsland(grid, i, j)) {
                        count++;
                    }
                }
            }
        }

        return count;
    }

    private boolean isClosedIsland(int[][] grid, int row, int col) {
        int rows = grid.length;
        int cols = grid[0].length;

        if (row < 0 || row >= rows || col < 0 || col >= cols) {
            return false;
        }

        if (grid[row][col] == 1) {
            return true;
        }

        grid[row][col] = 1;

        boolean up = isClosedIsland(grid, row - 1, col);
        boolean down = isClosedIsland(grid, row + 1, col);
        boolean left = isClosedIsland(grid, row, col - 1);
        boolean right = isClosedIsland(grid, row, col + 1);

        return up && down && left && right;
    }
}