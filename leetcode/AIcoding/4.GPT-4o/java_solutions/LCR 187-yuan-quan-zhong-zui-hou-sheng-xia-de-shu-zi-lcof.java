class Solution {
    public int[] findBall(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] result = new int[n];

        for (int j = 0; j < n; j++) {
            result[j] = simulateBallDrop(grid, 0, j);
        }
        return result;
    }

    private int simulateBallDrop(int[][] grid, int row, int col) {
        if (row == grid.length) return col;
        if (grid[row][col] == 1) {
            if (col == grid[0].length - 1 || grid[row][col + 1] == -1) {
                return -1;
            }
            return simulateBallDrop(grid, row + 1, col + 1);
        } else {
            if (col == 0 || grid[row][col - 1] == 1) {
                return -1;
            }
            return simulateBallDrop(grid, row + 1, col - 1);
        }
    }
}