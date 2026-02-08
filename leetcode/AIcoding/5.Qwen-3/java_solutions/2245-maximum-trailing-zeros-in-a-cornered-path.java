public class Solution {

import java.util.*;

public class Solution {
    public int corneredPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][][] zeros = new int[m][n][4]; // 0: up, 1: left, 2: down, 3: right

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int val = grid[i][j];
                int count = 0;
                while (val % 10 == 0) {
                    count++;
                    val /= 10;
                }
                zeros[i][j][0] = count;
                zeros[i][j][1] = count;
                zeros[i][j][2] = count;
                zeros[i][j][3] = count;
            }
        }

        for (int i = 1; i < m; i++) {
            for (int j = 0; j < n; j++) {
                zeros[i][j][0] += zeros[i - 1][j][0];
            }
        }

        for (int j = 1; j < n; j++) {
            for (int i = 0; i < m; i++) {
                zeros[i][j][1] += zeros[i][j - 1][1];
            }
        }

        for (int i = m - 2; i >= 0; i--) {
            for (int j = 0; j < n; j++) {
                zeros[i][j][2] += zeros[i + 1][j][2];
            }
        }

        for (int j = n - 2; j >= 0; j--) {
            for (int i = 0; i < m; i++) {
                zeros[i][j][3] += zeros[i][j + 1][3];
            }
        }

        int max = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int up = zeros[i][j][0];
                int left = zeros[i][j][1];
                int down = zeros[i][j][2];
                int right = zeros[i][j][3];

                if (i > 0 && j > 0) {
                    max = Math.max(max, up + left - zeros[i][j][0]);
                }
                if (i > 0 && j < n - 1) {
                    max = Math.max(max, up + right - zeros[i][j][0]);
                }
                if (i < m - 1 && j > 0) {
                    max = Math.max(max, down + left - zeros[i][j][0]);
                }
                if (i < m - 1 && j < n - 1) {
                    max = Math.max(max, down + right - zeros[i][j][0]);
                }
            }
        }

        return max;
    }
}
}