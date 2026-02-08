public class Solution {
    public int[] getSkyline(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] result = new int[m * n];

        int[] rowMax = new int[m];
        int[] colMax = new int[n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                rowMax[i] = Math.max(rowMax[i], grid[i][j]);
                colMax[j] = Math.max(colMax[j], grid[i][j]);
            }
        }

        int index = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                result[index++] = Math.min(rowMax[i], colMax[j]) - grid[i][j];
            }
        }

        return result;
    }
}