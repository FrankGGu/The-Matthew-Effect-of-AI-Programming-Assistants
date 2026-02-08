class Solution {
    public int latestDayToCross(int row, int col, int[][] cells) {
        int left = 0, right = cells.length - 1;
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canCross(row, col, cells, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return ans;
    }

    private boolean canCross(int row, int col, int[][] cells, int day) {
        int[][] grid = new int[row][col];
        for (int i = 0; i <= day; i++) {
            grid[cells[i][0] - 1][cells[i][1] - 1] = 1;
        }

        boolean[][] visited = new boolean[row][col];
        for (int j = 0; j < col; j++) {
            if (grid[0][j] == 0 && !visited[0][j]) {
                if (dfs(grid, visited, 0, j, row, col)) {
                    return true;
                }
            }
        }

        return false;
    }

    private boolean dfs(int[][] grid, boolean[][] visited, int i, int j, int row, int col) {
        if (i < 0 || i >= row || j < 0 || j >= col || grid[i][j] == 1 || visited[i][j]) {
            return false;
        }

        if (i == row - 1) {
            return true;
        }

        visited[i][j] = true;

        int[] dx = {0, 0, 1, -1};
        int[] dy = {1, -1, 0, 0};

        for (int k = 0; k < 4; k++) {
            int newI = i + dx[k];
            int newJ = j + dy[k];
            if (dfs(grid, visited, newI, newJ, row, col)) {
                return true;
            }
        }

        return false;
    }
}