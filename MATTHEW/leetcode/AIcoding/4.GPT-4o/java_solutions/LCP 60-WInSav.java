class Solution {
    public int[] findBall(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] result = new int[n];

        for (int j = 0; j < n; j++) {
            result[j] = dropBall(grid, 0, j);
        }

        return result;
    }

    private int dropBall(int[][] grid, int row, int col) {
        if (row == grid.length) return col;
        if (col < 0 || col >= grid[0].length) return -1;

        int direction = grid[row][col];
        if (direction == 1 && (col == grid[0].length - 1 || grid[row][col + 1] == -1)) {
            return -1;
        }
        if (direction == -1 && (col == 0 || grid[row][col - 1] == 1)) {
            return -1;
        }

        return dropBall(grid, row + 1, col + direction);
    }
}