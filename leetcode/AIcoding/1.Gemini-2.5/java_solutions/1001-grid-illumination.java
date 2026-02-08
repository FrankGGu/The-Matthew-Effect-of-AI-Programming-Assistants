import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public int[] gridIllumination(int n, int[][] lamps, int[][] queries) {
        Map<Integer, Integer> rowCounts = new HashMap<>();
        Map<Integer, Integer> colCounts = new HashMap<>();
        Map<Integer, Integer> diagCounts = new HashMap<>(); // r - c
        Map<Integer, Integer> antiDiagCounts = new HashMap<>(); // r + c
        Set<Long> activeLamps = new HashSet<>(); // Stores (r, c) as (long)r << 32 | c

        for (int[] lamp : lamps) {
            int r = lamp[0];
            int c = lamp[1];
            long lampKey = ((long) r << 32) | c;

            if (activeLamps.add(lampKey)) { // Add returns true if element was not present
                rowCounts.put(r, rowCounts.getOrDefault(r, 0) + 1);
                colCounts.put(c, colCounts.getOrDefault(c, 0) + 1);
                diagCounts.put(r - c, diagCounts.getOrDefault(r - c, 0) + 1);
                antiDiagCounts.put(r + c, antiDiagCounts.getOrDefault(r + c, 0) + 1);
            }
        }

        int[] results = new int[queries.length];
        int[][] directions = {
            {-1, -1}, {-1, 0}, {-1, 1},
            {0, -1}, {0, 0}, {0, 1},
            {1, -1}, {1, 0}, {1, 1}
        };

        for (int i = 0; i < queries.length; i++) {
            int qr = queries[i][0];
            int qc = queries[i][1];

            boolean illuminated = (rowCounts.getOrDefault(qr, 0) > 0 ||
                                   colCounts.getOrDefault(qc, 0) > 0 ||
                                   diagCounts.getOrDefault(qr - qc, 0) > 0 ||
                                   antiDiagCounts.getOrDefault(qr + qc, 0) > 0);

            results[i] = illuminated ? 1 : 0;

            if (illuminated) {
                for (int[] dir : directions) {
                    int nr = qr + dir[0];
                    int nc = qc + dir[1];

                    if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                        long neighborKey = ((long) nr << 32) | nc;
                        if (activeLamps.remove(neighborKey)) { // remove returns true if element was present
                            rowCounts.put(nr, rowCounts.get(nr) - 1);
                            colCounts.put(nc, colCounts.get(nc) - 1);
                            diagCounts.put(nr - nc, diagCounts.get(nr - nc) - 1);
                            antiDiagCounts.put(nr + nc, antiDiagCounts.get(nr + nc) - 1);
                        }
                    }
                }
            }
        }
        return results;
    }
}