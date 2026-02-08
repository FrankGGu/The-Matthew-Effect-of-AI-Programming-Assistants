class Solution {
    private int res;

    public int tilingRectangle(int n, int m) {
        res = n * m;
        boolean[][] grid = new boolean[n][m];
        dfs(grid, 0);
        return res;
    }

    private void dfs(boolean[][] grid, int cnt) {
        if (cnt >= res) return;
        int[] pos = findStart(grid);
        if (pos[0] == -1) {
            res = Math.min(res, cnt);
            return;
        }
        int x = pos[0], y = pos[1];
        int maxLen = Math.min(grid.length - x, grid[0].length - y);
        for (int len = maxLen; len >= 1; len--) {
            if (canPlace(grid, x, y, len)) {
                place(grid, x, y, len, true);
                dfs(grid, cnt + 1);
                place(grid, x, y, len, false);
            }
        }
    }

    private int[] findStart(boolean[][] grid) {
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (!grid[i][j]) {
                    return new int[]{i, j};
                }
            }
        }
        return new int[]{-1, -1};
    }

    private boolean canPlace(boolean[][] grid, int x, int y, int len) {
        for (int i = x; i < x + len; i++) {
            for (int j = y; j < y + len; j++) {
                if (grid[i][j]) {
                    return false;
                }
            }
        }
        return true;
    }

    private void place(boolean[][] grid, int x, int y, int len, boolean val) {
        for (int i = x; i < x + len; i++) {
            for (int j = y; j < y + len; j++) {
                grid[i][j] = val;
            }
        }
    }
}