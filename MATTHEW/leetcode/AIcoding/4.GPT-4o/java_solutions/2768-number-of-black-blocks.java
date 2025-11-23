class Solution {
    public int[] countBlackBlocks(int m, int n, int[][] coordinates) {
        int[] result = new int[2];
        boolean[][] grid = new boolean[m][n];
        int[][] directions = {{0, 0}, {0, 1}, {1, 0}, {1, 1}, {1, 1}, {-1, 0}, {-1, -1}, {0, -1}, {-1, 1}, {1, -1}};

        for (int[] coord : coordinates) {
            grid[coord[0]][coord[1]] = true;
        }

        int totalBlackBlocks = 0;
        int maxBlackBlocks = 0;

        for (int i = 0; i < m - 1; i++) {
            for (int j = 0; j < n - 1; j++) {
                int blackCount = 0;
                for (int[] dir : directions) {
                    int x = i + dir[0];
                    int y = j + dir[1];
                    if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y]) {
                        blackCount++;
                    }
                }
                if (blackCount > 0) {
                    totalBlackBlocks++;
                    maxBlackBlocks = Math.max(maxBlackBlocks, blackCount);
                }
            }
        }

        result[0] = totalBlackBlocks;
        result[1] = maxBlackBlocks;
        return result;
    }
}