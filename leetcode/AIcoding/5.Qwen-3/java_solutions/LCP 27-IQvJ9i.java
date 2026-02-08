public class Solution {
    public int blackBoxReflection(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        boolean[][] visited = new boolean[rows][cols];
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int[] dirIndex = {0};

        return dfs(0, 0, grid, visited, directions, dirIndex, rows, cols);
    }

    private int dfs(int row, int col, int[][] grid, boolean[][] visited, int[][] directions, int[] dirIndex, int rows, int cols) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || visited[row][col]) {
            return 0;
        }

        visited[row][col] = true;
        int count = 1;

        int[] dir = directions[dirIndex[0]];
        int newRow = row + dir[0];
        int newCol = col + dir[1];

        if (newRow < 0 || newRow >= rows || newCol < 0 || newCol >= cols || visited[newRow][newCol]) {
            return count;
        }

        dirIndex[0] = (dirIndex[0] + 1) % 4;
        return count + dfs(newRow, newCol, grid, visited, directions, dirIndex, rows, cols);
    }
}