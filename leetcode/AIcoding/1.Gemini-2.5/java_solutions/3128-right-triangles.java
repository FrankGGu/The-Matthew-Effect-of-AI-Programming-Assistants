class Solution {
    public long numberOfRightTriangles(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        int[] rowOnes = new int[rows];
        int[] colOnes = new int[cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    rowOnes[i]++;
                    colOnes[j]++;
                }
            }
        }

        long totalTriangles = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    long horizontalLegs = rowOnes[i] - 1;
                    long verticalLegs = colOnes[j] - 1;

                    if (horizontalLegs > 0 && verticalLegs > 0) {
                        totalTriangles += horizontalLegs * verticalLegs;
                    }
                }
            }
        }

        return totalTriangles;
    }
}