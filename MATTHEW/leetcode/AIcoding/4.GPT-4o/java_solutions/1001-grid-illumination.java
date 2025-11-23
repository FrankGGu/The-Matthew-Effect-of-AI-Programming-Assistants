import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class Solution {
    public int[] gridIllumination(int N, int[][] lamps, int[][] queries) {
        Map<Integer, Integer> rowCount = new HashMap<>();
        Map<Integer, Integer> colCount = new HashMap<>();
        Map<Integer, Integer> diagCount = new HashMap<>();
        Map<Integer, Integer> antiDiagCount = new HashMap<>();
        Set<String> lampSet = new HashSet<>();

        for (int[] lamp : lamps) {
            int r = lamp[0], c = lamp[1];
            String key = r + "," + c;
            if (!lampSet.contains(key)) {
                lampSet.add(key);
                rowCount.put(r, rowCount.getOrDefault(r, 0) + 1);
                colCount.put(c, colCount.getOrDefault(c, 0) + 1);
                diagCount.put(r - c, diagCount.getOrDefault(r - c, 0) + 1);
                antiDiagCount.put(r + c, antiDiagCount.getOrDefault(r + c, 0) + 1);
            }
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int r = queries[i][0], c = queries[i][1];
            if (rowCount.getOrDefault(r, 0) > 0 || colCount.getOrDefault(c, 0) > 0 
                || diagCount.getOrDefault(r - c, 0) > 0 || antiDiagCount.getOrDefault(r + c, 0) > 0) {
                result[i] = 1;
            } else {
                result[i] = 0;
            }
            for (int dr = -1; dr <= 1; dr++) {
                for (int dc = -1; dc <= 1; dc++) {
                    int nr = r + dr, nc = c + dc;
                    String key = nr + "," + nc;
                    if (lampSet.contains(key)) {
                        lampSet.remove(key);
                        rowCount.put(nr, rowCount.get(nr) - 1);
                        colCount.put(nc, colCount.get(nc) - 1);
                        diagCount.put(nr - nc, diagCount.get(nr - nc) - 1);
                        antiDiagCount.put(nr + nc, antiDiagCount.get(nr + nc) - 1);
                    }
                }
            }
        }
        return result;
    }
}