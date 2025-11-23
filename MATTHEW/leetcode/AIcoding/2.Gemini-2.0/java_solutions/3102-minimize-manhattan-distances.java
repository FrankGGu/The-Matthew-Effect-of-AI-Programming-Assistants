import java.util.Arrays;

class Solution {
    public int minTotalDistance(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int[] rows = new int[m];
        int[] cols = new int[n];

        int rowCount = 0;
        int colCount = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    rows[rowCount++] = i;
                    cols[colCount++] = j;
                }
            }
        }

        Arrays.sort(cols, 0, colCount);

        int rowMedian = rows[rowCount / 2];
        int colMedian = cols[colCount / 2];

        int distance = 0;
        for (int i = 0; i < rowCount; i++) {
            distance += Math.abs(rows[i] - rowMedian);
        }
        for (int i = 0; i < colCount; i++) {
            distance += Math.abs(cols[i] - colMedian);
        }

        return distance;
    }
}