class Solution {
    public int[][] fillGrid(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] res = new int[m][n];

        int[] rowMax = new int[m];
        int[] colMax = new int[n];

        for (int i = 0; i < m; i++) {
            int max = Integer.MIN_VALUE;
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > max) {
                    max = grid[i][j];
                }
            }
            rowMax[i] = max;
        }

        for (int j = 0; j < n; j++) {
            int max = Integer.MIN_VALUE;
            for (int i = 0; i < m; i++) {
                if (grid[i][j] > max) {
                    max = grid[i][j];
                }
            }
            colMax[j] = max;
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                res[i][j] = Math.min(rowMax[i], colMax[j]);
            }
        }

        return res;
    }
}