public class Solution {

import java.util.*;

public class Solution {
    public int equalPairs(int[][] grid) {
        Map<String, Integer> rowMap = new HashMap<>();
        int count = 0;

        for (int[] row : grid) {
            StringBuilder sb = new StringBuilder();
            for (int num : row) {
                sb.append(num).append(",");
            }
            String key = sb.toString();
            rowMap.put(key, rowMap.getOrDefault(key, 0) + 1);
        }

        for (int col = 0; col < grid[0].length; col++) {
            StringBuilder sb = new StringBuilder();
            for (int row = 0; row < grid.length; row++) {
                sb.append(grid[row][col]).append(",");
            }
            String key = sb.toString();
            count += rowMap.getOrDefault(key, 0);
        }

        return count;
    }
}
}