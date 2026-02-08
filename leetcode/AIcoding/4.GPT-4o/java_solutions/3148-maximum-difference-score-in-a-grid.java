class Solution {
    public int maxDifference(int[][] grid) {
        int rows = grid.length, cols = grid[0].length;
        int[][] maxFromTopLeft = new int[rows][cols];
        int[][] minFromBottomRight = new int[rows][cols];

        maxFromTopLeft[0][0] = grid[0][0];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (i > 0) maxFromTopLeft[i][j] = Math.max(maxFromTopLeft[i][j], maxFromTopLeft[i - 1][j]);
                if (j > 0) maxFromTopLeft[i][j] = Math.max(maxFromTopLeft[i][j], maxFromTopLeft[i][j - 1]);
                maxFromTopLeft[i][j] = Math.max(maxFromTopLeft[i][j], grid[i][j]);
            }
        }

        minFromBottomRight[rows - 1][cols - 1] = grid[rows - 1][cols - 1];
        for (int i = rows - 1; i >= 0; i--) {
            for (int j = cols - 1; j >= 0; j--) {
                if (i < rows - 1) minFromBottomRight[i][j] = Math.min(minFromBottomRight[i][j], minFromBottomRight[i + 1][j]);
                if (j < cols - 1) minFromBottomRight[i][j] = Math.min(minFromBottomRight[i][j], minFromBottomRight[i][j + 1]);
                minFromBottomRight[i][j] = Math.min(minFromBottomRight[i][j], grid[i][j]);
            }
        }

        int maxDiff = Integer.MIN_VALUE;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                maxDiff = Math.max(maxDiff, maxFromTopLeft[i][j] - minFromBottomRight[i][j]);
            }
        }
        return maxDiff;
    }
}