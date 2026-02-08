public class Solution {
    public int projectionArea(int[][] grid) {
        int area = 0;
        int[] rowMax = new int[grid.length];
        int[] colMax = new int[grid[0].length];

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[i].length; j++) {
                if (grid[i][j] > 0) {
                    area++;
                }
                rowMax[i] = Math.max(rowMax[i], grid[i][j]);
                colMax[j] = Math.max(colMax[j], grid[i][j]);
            }
        }

        for (int i = 0; i < rowMax.length; i++) {
            area += rowMax[i];
        }

        for (int j = 0; j < colMax.length; j++) {
            area += colMax[j];
        }

        return area;
    }
}