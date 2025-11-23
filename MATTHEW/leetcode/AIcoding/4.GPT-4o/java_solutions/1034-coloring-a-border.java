class Solution {
    public int[][] colorBorder(int[][] grid, int row, int col, int color) {
        int m = grid.length, n = grid[0].length;
        int originalColor = grid[row][col];
        boolean[][] visited = new boolean[m][n];
        List<int[]> border = new ArrayList<>();

        DFS(grid, row, col, originalColor, visited, border);

        for (int[] b : border) {
            grid[b[0]][b[1]] = color;
        }

        return grid;
    }

    private void DFS(int[][] grid, int row, int col, int originalColor, boolean[][] visited, List<int[]> border) {
        if (row < 0 || row >= grid.length || col < 0 || col >= grid[0].length || visited[row][col] || grid[row][col] != originalColor) {
            return;
        }

        visited[row][col] = true;
        int count = 0;

        for (int[] dir : new int[][]{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}) {
            int newRow = row + dir[0];
            int newCol = col + dir[1];
            if (newRow < 0 || newRow >= grid.length || newCol < 0 || newCol >= grid[0].length) {
                count++;
            } else if (grid[newRow][newCol] != originalColor) {
                count++;
            } else if (!visited[newRow][newCol]) {
                DFS(grid, newRow, newCol, originalColor, visited, border);
            }
        }

        if (count > 0) {
            border.add(new int[]{row, col});
        }
    }
}