import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxPoints(int[][] points) {
        int n = points.length;
        if (n <= 2) {
            return n;
        }

        int maxPoints = 2;
        for (int i = 0; i < n; i++) {
            Map<Double, Integer> slopeCount = new HashMap<>();
            int samePoints = 1;
            for (int j = i + 1; j < n; j++) {
                if (points[i][0] == points[j][0] && points[i][1] == points[j][1]) {
                    samePoints++;
                } else {
                    double slope;
                    if (points[i][0] == points[j][0]) {
                        slope = Double.POSITIVE_INFINITY;
                    } else {
                        slope = (double) (points[j][1] - points[i][1]) / (points[j][0] - points[i][0]);
                    }
                    slopeCount.put(slope, slopeCount.getOrDefault(slope, 1) + 1);
                }
            }

            int currentMax = samePoints;
            for (int count : slopeCount.values()) {
                currentMax = Math.max(currentMax, count + samePoints);
            }
            maxPoints = Math.max(maxPoints, currentMax);
        }

        return maxPoints;
    }
}