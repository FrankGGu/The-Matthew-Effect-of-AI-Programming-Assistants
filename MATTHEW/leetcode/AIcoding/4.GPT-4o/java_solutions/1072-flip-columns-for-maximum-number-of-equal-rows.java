import java.util.HashMap;

public class Solution {
    public int maxEqualRowsAfterFlips(int[][] matrix) {
        HashMap<String, Integer> map = new HashMap<>();
        int maxCount = 0;

        for (int[] row : matrix) {
            StringBuilder key = new StringBuilder();
            for (int j = 0; j < row.length; j++) {
                key.append(row[j] ^ row[0]);
            }
            String pattern = key.toString();
            map.put(pattern, map.getOrDefault(pattern, 0) + 1);
            maxCount = Math.max(maxCount, map.get(pattern));
        }

        return maxCount;
    }
}