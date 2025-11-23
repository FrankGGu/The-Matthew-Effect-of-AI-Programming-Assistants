public class Solution {

import java.util.*;

public class Solution {
    public int maxGame(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] maxVal = new int[m][n];
        int[][] minVal = new int[m][n];

        maxVal[0][0] = grid[0][0];
        minVal[0][0] = grid[0][0];

        for (int i = 1; i < m; i++) {
            maxVal[i][0] = maxVal[i - 1][0] * grid[i][0];
            minVal[i][0] = minVal[i - 1][0] * grid[i][0];
        }

        for (int j = 1; j < n; j++) {
            maxVal[0][j] = maxVal[0][j - 1] * grid[0][j];
            minVal[0][j] = minVal[0][j - 1] * grid[0][j];
        }

        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                int[] temp = new int[4];
                temp[0] = maxVal[i - 1][j] * grid[i][j];
                temp[1] = minVal[i - 1][j] * grid[i][j];
                temp[2] = maxVal[i][j - 1] * grid[i][j];
                temp[3] = minVal[i][j - 1] * grid[i][j];

                Arrays.sort(temp);
                maxVal[i][j] = temp[3];
                minVal[i][j] = temp[0];
            }
        }

        return maxVal[m - 1][n - 1];
    }
}
}