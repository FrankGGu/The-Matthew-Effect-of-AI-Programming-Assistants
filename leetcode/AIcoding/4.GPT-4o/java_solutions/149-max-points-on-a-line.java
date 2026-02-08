import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int maxPoints(int[][] points) {
        if (points.length < 2) return points.length;
        int maxPoints = 0;

        for (int i = 0; i < points.length; i++) {
            Map<String, Integer> slopeCount = new HashMap<>();
            int duplicate = 1;

            for (int j = i + 1; j < points.length; j++) {
                if (points[i][0] == points[j][0] && points[i][1] == points[j][1]) {
                    duplicate++;
                    continue;
                }
                int dx = points[j][0] - points[i][0];
                int dy = points[j][1] - points[i][1];
                int gcd = gcd(dx, dy);
                dx /= gcd;
                dy /= gcd;
                String slope = dx + "," + dy;
                slopeCount.put(slope, slopeCount.getOrDefault(slope, 0) + 1);
            }

            int currentMax = duplicate;
            for (int count : slopeCount.values()) {
                currentMax = Math.max(currentMax, count + duplicate);
            }
            maxPoints = Math.max(maxPoints, currentMax);
        }
        return maxPoints;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}