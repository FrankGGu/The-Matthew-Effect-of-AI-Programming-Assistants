public class Solution {

import java.util.*;

public class Solution {
    public int largestSubmatrix(String[] matrix) {
        int m = matrix.length;
        int n = matrix[0].length();

        int[][] grid = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (matrix[i].charAt(j) == '1') {
                    grid[i][j] = (i == 0) ? 1 : grid[i - 1][j] + 1;
                }
            }
        }

        int maxArea = 0;

        for (int i = 0; i < m; i++) {
            Arrays.sort(grid[i]);
            for (int j = n - 1; j >= 0; j--) {
                int height = grid[i][j];
                int width = n - j;
                maxArea = Math.max(maxArea, height * width);
            }
        }

        return maxArea;
    }
}
}