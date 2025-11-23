class Solution {
    public int numPoints(int[][] points, int r) {
        int n = points.length;
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }

        int maxPoints = 1;
        double EPSILON = 1e-9;

        for (int i = 0; i < n; i++) {
            double cx = points[i][0];
            double cy = points[i][1];
            int currentPoints = 0;
            for (int k = 0; k < n; k++) {
                if (distanceSq(cx, cy, points[k][0], points[k][1]) <= r * r + EPSILON) {
                    currentPoints++;
                }
            }
            maxPoints = Math.max(maxPoints, currentPoints);
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                double x1 = points[i][0];
                double y1 = points[i][1];
                double x2 = points[j][0];
                double y2 = points[j][1];

                double distSq = distanceSq(x1, y1, x2, y2);
                double dist = Math.sqrt(distSq);

                if (dist > 2 * r + EPSILON) {
                    continue;
                }

                if (dist < EPSILON) {
                    continue;
                }

                double midX = (x1 + x2) / 2.0;
                double midY = (y1 + y2) / 2.0;

                double hSq = r * r - (distSq / 4.0);
                if (hSq < 0) hSq = 0; 
                double h = Math.sqrt(hSq);

                double dx = x2 - x1;
                double dy = y2 - y1;

                double ux = -dy / dist;
                double uy = dx / dist;

                double cx1 = midX + h * ux;
                double cy1 = midY + h * uy;

                double cx2 = midX - h * ux;
                double cy2 = midY - h * uy;

                int currentPoints1 = 0;
                for (int k = 0; k < n; k++) {
                    if (distanceSq(cx1, cy1, points[k][0], points[k][1]) <= r * r + EPSILON) {
                        currentPoints1++;
                    }
                }
                maxPoints = Math.max(maxPoints, currentPoints1);

                int currentPoints2 = 0;
                for (int k = 0; k < n; k++) {
                    if (distanceSq(cx2, cy2, points[k][0], points[k][1]) <= r * r + EPSILON) {
                        currentPoints2++;
                    }
                }
                maxPoints = Math.max(maxPoints, currentPoints2);
            }
        }

        return maxPoints;
    }

    private double distanceSq(double x1, double y1, double x2, double y2) {
        return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
    }
}