public class Solution {

import java.util.*;

public class Solution {
    public int[] guardPosition(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[] result = new int[2];
        int maxCount = 0;

        for (int i = 0; i < rows; i++) {
            int count = 0;
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    count++;
                }
            }
            if (count > maxCount) {
                maxCount = count;
                result[0] = i;
                result[1] = 0;
            } else if (count == maxCount) {
                result[1]++;
            }
        }

        for (int j = 0; j < cols; j++) {
            int count = 0;
            for (int i = 0; i < rows; i++) {
                if (grid[i][j] == 1) {
                    count++;
                }
            }
            if (count > maxCount) {
                maxCount = count;
                result[0] = 0;
                result[1] = j;
            } else if (count == maxCount) {
                result[0]++;
            }
        }

        return result;
    }
}
}