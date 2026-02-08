import java.util.ArrayList;
import java.util.List;

class Solution {

    private static final double EPSILON = 1e-9;

    static class Point {
        double x, y;

        Point(double x, double y) {
            this.x = x;
            this.y = y;
        }
    }

    private double distSq(Point p1, Point p2) {
        double dx = p1.x - p2.x;
        double dy = p1.y - p2.y;
        return dx * dx + dy * dy;
    }

    public int maxMolesHit(int[][] molesArray, int R) {
        if (molesArray == null || molesArray.length == 0) {
            return 0;
        }

        List<Point> moles = new ArrayList<>();
        for (int[] mole : molesArray) {
            moles.add(new Point(mole[0], mole[1]));
        }

        int n = moles.size();
        int maxMoles = 1;

        double R_sq = (double) R * R;

        for (int i = 0; i < n; i++) {
            int currentCount = 0;
            Point center = moles.get(i);
            for (int j = 0; j < n; j++) {
                if (distSq(center, moles.get(j)) <= R_sq + EPSILON) {
                    currentCount++;
                }
            }
            maxMoles = Math.max(maxMoles, currentCount);
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                Point p1 = moles.get(i);
                Point p2 = moles.get(j);

                double d_sq = distSq(p1, p2);
                double d = Math.sqrt(d_sq);

                if (d > 2.0 * R + EPSILON) {
                    continue;
                }

                double d_half = d / 2.0;
                double h_sq = R_sq - d_half * d_half;
                double h = Math.sqrt(Math.max(0.0, h_sq));

                double mid_x = (p1.x + p2.x) / 2.0;
                double mid_y = (p1.y + p2.y) / 2.0;

                double dx_p1p2 = p2.x - p1.x;
                double dy_p1p2 = p2.y - p1.y;

                double unit_dx_perp = -dy_p1p2 / d;
                double unit_dy_perp = dx_p1p2 / d;

                Point center1 = new Point(mid_x + h * unit_dx_perp, mid_y + h * unit_dy_perp);
                Point center2 = new Point(mid_x - h * unit_dx_perp, mid_y - h * unit_dy_perp);

                int currentCount1 = 0;
                for (int k = 0; k < n; k++) {
                    if (distSq(center1, moles.get(k)) <= R_sq + EPSILON) {
                        currentCount1++;
                    }
                }
                maxMoles = Math.max(maxMoles, currentCount1);

                int currentCount2 = 0;
                for (int k = 0; k < n; k++) {
                    if (distSq(center2, moles.get(k)) <= R_sq + EPSILON) {
                        currentCount2++;
                    }
                }
                maxMoles = Math.max(maxMoles, currentCount2);
            }
        }

        return maxMoles;
    }
}