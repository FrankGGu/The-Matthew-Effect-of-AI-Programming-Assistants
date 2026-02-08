class Solution {
    public int latestDayToCross(int row, int col, int[][] cells) {
        int left = 1, right = cells.length, answer = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canCross(row, col, cells, mid)) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return answer;
    }

    private boolean canCross(int row, int col, int[][] cells, int day) {
        boolean[][] grid = new boolean[row][col];
        for (int i = 0; i < day; i++) {
            grid[cells[i][0] - 1][cells[i][1] - 1] = true;
        }

        boolean[] visited = new boolean[col];
        for (int j = 0; j < col; j++) {
            if (!grid[0][j]) {
                if (dfs(grid, 0, j, visited)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean dfs(boolean[][] grid, int r, int c, boolean[] visited) {
        if (r == grid.length - 1) {
            return true;
        }
        if (c < 0 || c >= grid[0].length || grid[r][c] || visited[c]) {
            return false;
        }

        visited[c] = true;
        return dfs(grid, r + 1, c, visited) || dfs(grid, r + 1, c - 1, visited) || dfs(grid, r + 1, c + 1, visited);
    }
}