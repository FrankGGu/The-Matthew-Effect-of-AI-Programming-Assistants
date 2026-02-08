public class Solution {

import java.util.Arrays;

public class Solution {
    public int deleteGreatestValue(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        for (int i = 0; i < rows; i++) {
            Arrays.sort(grid[i]);
        }

        int result = 0;
        for (int j = 0; j < cols; j++) {
            int max = 0;
            for (int i = 0; i < rows; i++) {
                if (grid[i][j] > max) {
                    max = grid[i][j];
                }
            }
            result += max;
        }

        return result;
    }
}
}