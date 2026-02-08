public class Solution {
    int[][] grid;
    int rows, cols;
    int totalSteps;
    int result;

    public int uniquePathsIII(int[][] grid) {
        this.grid = grid;
        rows = grid.length;
        cols = grid[0].length;
        int startRow = -1, startCol = -1;
        totalSteps = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    startRow = i;
                    startCol = j;
                } else if (grid[i][j] == 0) {
                    totalSteps++;
                }
            }
        }

        totalSteps += 1; // include the starting cell
        result = 0;
        dfs(startRow, startCol, 0);
        return result;
    }

    private void dfs(int row, int col, int steps) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] == -1) {
            return;
        }

        if (grid[row][col] == 2) {
            if (steps == totalSteps) {
                result++;
            }
            return;
        }

        int temp = grid[row][col];
        grid[row][col] = -1;

        dfs(row + 1, col, steps + 1);
        dfs(row - 1, col, steps + 1);
        dfs(row, col + 1, steps + 1);
        dfs(row, col - 1, steps + 1);

        grid[row][col] = temp;
    }
}