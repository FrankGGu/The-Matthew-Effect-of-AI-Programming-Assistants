import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxEqualRowsAfterFlips(int[][] matrix) {
        Map<String, Integer> count = new HashMap<>();
        int res = 0;
        for (int[] row : matrix) {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < row.length; i++) {
                sb.append(row[0] ^ row[i]);
            }
            String s = sb.toString();
            count.put(s, count.getOrDefault(s, 0) + 1);
            res = Math.max(res, count.get(s));
        }
        return res;
    }
}