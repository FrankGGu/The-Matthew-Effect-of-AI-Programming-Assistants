import java.lang.Math;

class Solution {
    public double maxDistance(int[][] points) {
        double maxDistSq = 0.0;
        int n = points.length;

        if (n < 2) {
            return 0.0;
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                long dx = points[i][0] - points[j][0];
                long dy = points[i][1] - points[j][1];
                double distSq = (double)dx * dx + (double)dy * dy;
                if (distSq > maxDistSq) {
                    maxDistSq = distSq;
                }
            }
        }

        return Math.sqrt(maxDistSq);
    }
}