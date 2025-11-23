class Solution {
    public int[][] largestLocal(int[][] grid) {
        int n = grid.length - 2;
        int[][] result = new int[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int maxVal = 0;
                for (int x = i; x < i + 3; x++) {
                    for (int y = j; y < j + 3; y++) {
                        maxVal = Math.max(maxVal, grid[x][y]);
                    }
                }
                result[i][j] = maxVal;
            }
        }

        return result;
    }
}