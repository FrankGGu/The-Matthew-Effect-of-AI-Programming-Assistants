public class Solution {

import java.util.*;

public class Solution {
    public int[] bestCoordinate(String[][] grid, int radius) {
        int n = grid.length;
        int m = grid[0].length;
        int[][] quality = new int[n][m];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                int q = Integer.parseInt(grid[i][j]);
                if (q > 0) {
                    for (int x = Math.max(0, i - radius); x <= Math.min(n - 1, i + radius); x++) {
                        for (int y = Math.max(0, j - radius); y <= Math.min(m - 1, j + radius); y++) {
                            double distance = Math.sqrt((x - i) * (x - i) + (y - j) * (y - j));
                            if (distance <= radius) {
                                quality[x][y] += q;
                            }
                        }
                    }
                }
            }
        }

        int maxQuality = -1;
        int[] result = {0, 0};

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (quality[i][j] > maxQuality) {
                    maxQuality = quality[i][j];
                    result[0] = i;
                    result[1] = j;
                } else if (quality[i][j] == maxQuality && (i < result[0] || (i == result[0] && j < result[1]))) {
                    result[0] = i;
                    result[1] = j;
                }
            }
        }

        return result;
    }
}
}