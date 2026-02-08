class Solution {
    public int[][] findRegionAverage(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] result = new int[m][n];
        int[][] directions = {{0,1}, {1,0}, {0,-1}, {-1,0}};

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int sum = grid[i][j], count = 1;
                for (int[] dir : directions) {
                    int ni = i + dir[0], nj = j + dir[1];
                    if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                        sum += grid[ni][nj];
                        count++;
                    }
                }
                result[i][j] = sum / count;
            }
        }

        return result;
    }
}