public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> gridInterview(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        List<Integer> result = new ArrayList<>();

        for (int j = 0; j < cols; j++) {
            int maxWidth = 0;
            for (int i = 0; i < rows; i++) {
                String numStr = String.valueOf(grid[i][j]);
                maxWidth = Math.max(maxWidth, numStr.length());
            }
            result.add(maxWidth);
        }

        return result;
    }
}
}