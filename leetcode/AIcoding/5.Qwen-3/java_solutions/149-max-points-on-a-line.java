public class Solution {

import java.util.*;

public class Solution {
    public int maxPoints(int[][] points) {
        if (points == null || points.length == 0) return 0;
        if (points.length == 1) return 1;

        int max = 0;
        for (int i = 0; i < points.length; i++) {
            Map<String, Integer> slopeCount = new HashMap<>();
            int same = 0;
            int currentMax = 0;
            for (int j = 0; j < points.length; j++) {
                if (i == j) continue;
                int dx = points[i][0] - points[j][0];
                int dy = points[i][1] - points[j][1];
                if (dx == 0 && dy == 0) {
                    same++;
                    continue;
                }
                int gcd = gcd(dx, dy);
                String slope = (dx / gcd) + "," + (dy / gcd);
                slopeCount.put(slope, slopeCount.getOrDefault(slope, 0) + 1);
                currentMax = Math.max(currentMax, slopeCount.get(slope));
            }
            max = Math.max(max, currentMax + same + 1);
        }
        return max;
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
}