import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numberOfBoomerangs(int[][] points) {
        int count = 0;
        for (int i = 0; i < points.length; i++) {
            Map<Integer, Integer> distMap = new HashMap<>();
            for (int j = 0; j < points.length; j++) {
                if (i == j) continue;
                int dist = (points[i][0] - points[j][0]) * (points[i][0] - points[j][0]) +
                           (points[i][1] - points[j][1]) * (points[i][1] - points[j][1]);
                distMap.put(dist, distMap.getOrDefault(dist, 0) + 1);
            }
            for (int val : distMap.values()) {
                count += val * (val - 1);
            }
        }
        return count;
    }
}