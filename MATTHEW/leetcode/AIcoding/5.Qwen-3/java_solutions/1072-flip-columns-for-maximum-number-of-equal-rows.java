public class Solution {

import java.util.*;

public class Solution {
    public int maxEqualRowsAfterFlip(int[][] matrix) {
        Map<String, Integer> patternCount = new HashMap<>();
        for (int[] row : matrix) {
            StringBuilder pattern = new StringBuilder();
            for (int j = 0; j < row.length; j++) {
                if (row[j] != row[0]) {
                    pattern.append(j).append(",");
                }
            }
            String key = pattern.toString();
            patternCount.put(key, patternCount.getOrDefault(key, 0) + 1);
        }
        return Collections.max(patternCount.values());
    }
}
}