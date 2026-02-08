class Solution {
    private int m, n;
    private int[][] currentGrid;
    private int[][] dirs = {{0, 0}, {0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    private void flip(int r, int c) {
        for (int[] dir : dirs) {
            int nr = r + dir[0];
            int nc = c + dir[1];
            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                currentGrid[nr][nc] = 1 - currentGrid[nr][nc];
            }
        }
    }

    public int magicTower(int[][] grid) {
        m = grid.length;
        n = grid[0].length;

        int minFlips = Integer.MAX_VALUE;

        for (int i = 0; i < (1 << n); i++) {
            currentGrid = new int[m][n];
            for (int r = 0; r < m; r++) {
                System.arraycopy(grid[r], 0, currentGrid[r], 0, n);
            }

            int currentFlips = 0;

            for (int j = 0; j < n; j++) {
                if (((i >> j) & 1) == 1) {
                    flip(0, j);
                    currentFlips++;
                }
            }

            for (int r = 1; r < m; r++) {
                for (int c = 0; c < n; c++) {
                    if (currentGrid[r - 1][c] == 1) {
                        flip(r, c);
                        currentFlips++;
                    }
                }
            }

            boolean allZero = true;
            for (int c = 0; c < n; c++) {
                if (currentGrid[m - 1][c] == 1) {
                    allZero = false;
                    break;
                }
            }

            if (allZero) {
                minFlips = Math.min(minFlips, currentFlips);
            }
        }

        return minFlips == Integer.MAX_VALUE ? -1 : minFlips;
    }
}