public class Solution {

import java.util.*;

public class Solution {
    public int maxPoints(int[][] points) {
        int n = points.length;
        if (n == 0) return 0;
        if (n == 1) return 1;

        int maxPoints = 1;

        for (int i = 0; i < n; i++) {
            Map<String, Integer> slopeCount = new HashMap<>();
            int samePoints = 0;
            int currentMax = 0;

            for (int j = 0; j < n; j++) {
                if (i == j) continue;
                int dx = points[j][0] - points[i][0];
                int dy = points[j][1] - points[i][1];

                if (dx == 0 && dy == 0) {
                    samePoints++;
                    continue;
                }

                int gcd = gcd(dx, dy);
                String slope = (dx / gcd) + "," + (dy / gcd);

                slopeCount.put(slope, slopeCount.getOrDefault(slope, 0) + 1);
                currentMax = Math.max(currentMax, slopeCount.get(slope));
            }

            maxPoints = Math.max(maxPoints, currentMax + samePoints + 1);
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
}