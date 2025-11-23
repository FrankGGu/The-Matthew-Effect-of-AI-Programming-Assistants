import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numberOfBoomerangs(int[][] points) {
        int n = points.length;
        if (n < 3) {
            return 0;
        }

        int boomerangs = 0;

        for (int i = 0; i < n; i++) {
            Map<Integer, Integer> distanceCounts = new HashMap<>();
            for (int j = 0; j < n; j++) {
                if (i == j) {
                    continue;
                }
                int dx = points[i][0] - points[j][0];
                int dy = points[i][1] - points[j][1];
                int distSq = dx * dx + dy * dy;
                distanceCounts.put(distSq, distanceCounts.getOrDefault(distSq, 0) + 1);
            }

            for (int count : distanceCounts.values()) {
                if (count >= 2) {
                    boomerangs += count * (count - 1);
                }
            }
        }

        return boomerangs;
    }
}