class Solution {
    public int[] findBall(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] result = new int[n];

        for (int j = 0; j < n; j++) {
            result[j] = dropBall(grid, 0, j);
        }

        return result;
    }

    private int dropBall(int[][] grid, int row, int col) {
        if (row == grid.length) {
            return col;
        }

        int direction = grid[row][col];
        int nextCol = col + direction;

        if (nextCol < 0 || nextCol >= grid[0].length || grid[row][col] != grid[row][nextCol]) {
            return -1;
        }

        return dropBall(grid, row + 1, nextCol);
    }
}