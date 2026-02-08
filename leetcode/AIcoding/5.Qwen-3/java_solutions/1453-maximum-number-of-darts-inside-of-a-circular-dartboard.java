public class Solution {

import java.util.*;

public class Solution {
    public int maxNumber of Darts(int[][] darts) {
        int n = darts.length;
        if (n == 1) return 1;
        if (n == 2) return 2;
        int max = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                double[] center = getCircleCenter(darts[i], darts[j], darts[0]);
                if (center != null) {
                    int count = 0;
                    for (int k = 0; k < n; k++) {
                        if (isInsideCircle(darts[k], center, darts[i], darts[j])) {
                            count++;
                        }
                    }
                    max = Math.max(max, count);
                }
            }
        }
        return max;
    }

    private double[] getCircleCenter(int[] p1, int[] p2, int[] p3) {
        double x1 = p1[0], y1 = p1[1];
        double x2 = p2[0], y2 = p2[1];
        double x3 = p3[0], y3 = p3[1];

        double A = x2 - x1;
        double B = y2 - y1;
        double C = x3 - x1;
        double D = y3 - y1;

        double E = A * (x1 + x2) + B * (y1 + y2);
        double F = C * (x1 + x3) + D * (y1 + y3);

        double G = 2 * (A * (y3 - y2) - B * (x3 - x2));

        if (G == 0) return null;

        double x = (F * B - E * D) / G;
        double y = (E * C - F * A) / G;

        return new double[]{x, y};
    }

    private boolean isInsideCircle(int[] p, double[] center, int[] p1, int[] p2) {
        double x = p[0], y = p[1];
        double cx = center[0], cy = center[1];
        double r = Math.hypot(p1[0] - p2[0], p1[1] - p2[1]) / 2;
        return Math.hypot(x - cx, y - cy) <= r + 1e-8;
    }
}
}