import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxEqualRowsAfterFlips(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;

        Map<String, Integer> patternCounts = new HashMap<>();
        int maxCount = 0;

        for (int i = 0; i < m; i++) {
            StringBuilder sb = new StringBuilder();
            int firstElement = mat[i][0];
            for (int j = 0; j < n; j++) {
                sb.append(mat[i][j] ^ firstElement);
            }
            String pattern = sb.toString();
            patternCounts.put(pattern, patternCounts.getOrDefault(pattern, 0) + 1);
            maxCount = Math.max(maxCount, patternCounts.get(pattern));
        }

        return maxCount;
    }
}