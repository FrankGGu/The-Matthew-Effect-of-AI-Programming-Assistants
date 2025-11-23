class Solution {
    public int[][] largestLocal(int[][] grid) {
        int n = grid.length;
        int[][] result = new int[n - 2][n - 2];

        for (int i = 0; i < n - 2; i++) {
            for (int j = 0; j < n - 2; j++) {
                int maxVal = 0; // Constraints state grid values are between 1 and 100
                for (int r = i; r <= i + 2; r++) {
                    for (int c = j; c <= j + 2; c++) {
                        if (grid[r][c] > maxVal) {
                            maxVal = grid[r][c];
                        }
                    }
                }
                result[i][j] = maxVal;
            }
        }
        return result;
    }
}