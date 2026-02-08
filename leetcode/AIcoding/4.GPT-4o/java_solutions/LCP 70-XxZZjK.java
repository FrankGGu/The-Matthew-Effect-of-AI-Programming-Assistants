class Solution {
    public int sandPile(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int totalSand = 0;

        for (int[] row : grid) {
            for (int sand : row) {
                totalSand += sand;
            }
        }

        int target = totalSand / (m * n);
        int remainingSand = totalSand % (m * n);
        int[][] result = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                result[i][j] = target;
            }
        }

        for (int i = 0; i < remainingSand; i++) {
            result[i / n][i % n]++;
        }

        return result;
    }
}