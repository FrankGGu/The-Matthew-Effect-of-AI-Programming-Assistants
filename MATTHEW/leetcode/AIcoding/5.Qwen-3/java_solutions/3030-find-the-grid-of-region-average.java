public class Solution {

import java.util.*;

public class Solution {
    public int[][] gridRegionAverage(int[][] grid, int regionSize) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] result = new int[m][n];
        int[][] prefixSum = new int[m + 1][n + 1];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                prefixSum[i + 1][j + 1] = grid[i][j] + prefixSum[i][j + 1] + prefixSum[i + 1][j] - prefixSum[i][j];
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int x1 = Math.max(0, i - regionSize + 1);
                int y1 = Math.max(0, j - regionSize + 1);
                int x2 = Math.min(m, i + regionSize);
                int y2 = Math.min(n, j + regionSize);

                int sum = prefixSum[x2][y2] - prefixSum[x1][y2] - prefixSum[x2][y1] + prefixSum[x1][y1];
                int count = (x2 - x1) * (y2 - y1);
                result[i][j] = sum / count;
            }
        }

        return result;
    }
}
}