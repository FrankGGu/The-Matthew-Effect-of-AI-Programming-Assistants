class Solution {
    public int numPoints(int[][] points, int r) {
        int n = points.length;
        if (n == 0) {
            return 0;
        }
        // If there's at least one dart, it can always be covered by a circle of radius r.
        int maxDarts = 1; 

        double R = (double) r;
        double R_SQ = R * R;
        double EPS = 1e-9; // Epsilon for floating point comparisons to handle precision issues

        // Iterate through all pairs of distinct points (P_i, P_j)
        // An optimal circle (of fixed radius R) will have at least two points on its circumference,
        // unless it contains only one point (handled by maxDarts = 1).
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) { // j starts from i+1 to ensure distinct points
                double x1 = points[i][0];
                double y1 = points[i][1];
                double x2 = points[j][0];
                double y2 = points[j][1];

                // Calculate squared distance between P1 and P2
                double d_sq = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);

                // If the distance between P1 and P2 is greater than 2*R,
                // they cannot both lie on the circumference of a circle with radius R,
                // nor can they both be inside such a circle.
                if (d_sq > 4 * R_SQ + EPS) { 
                    continue;
                }

                // Calculate midpoint M of P1P2
                double midX = (x1 + x2) / 2.0;
                double midY = (y1 + y2) / 2.0;

                // Calculate the squared distance from M to the center C.
                // This is derived from the Pythagorean theorem: R^2 = (d/2)^2 + h^2
                // So, h^2 = R^2 - (d/2)^2 = R^2 - d_sq/4
                double h_sq = R_SQ - d_sq / 4.0;

                // Due to floating point precision, h_sq might be slightly negative when it should be 0.
                // Clamp it to 0 to avoid NaN from Math.sqrt().
                if (h_sq < 0) { 
                    h_sq = 0; 
                }
                double h = Math.sqrt(h_sq);

                // Vector P1P2
                double dx = x2 - x1;
                double dy = y2 - y1;

                // Calculate a unit vector perpendicular to P1P2.
                // The vector (-dy, dx) is perpendicular to (dx, dy).
                // Its length is sqrt(dx*dx + dy*dy), which is sqrt(d_sq).
                // Since P1 and P2 are distinct (j starts from i+1), d_sq > 0, so vec_len > 0.
                double vec_len = Math.sqrt(d_sq); 
                double unit_norm_x = -dy / vec_len;
                double unit_norm_y = dx / vec_len;

                // There are two possible centers (C1, C2) for circles of radius R
                // that pass through P1 and P2.
                // Center 1: M + h * unit_normal_vector
                double c1x = midX + h * unit_norm_x;
                double c1y = midY + h * unit_norm_y;
                maxDarts = Math.max(maxDarts, countDarts(points, c1x, c1y, R_SQ, EPS));

                // Center 2: M - h * unit_normal_vector
                double c2x = midX - h * unit_norm_x;
                double c2y = midY - h * unit_norm_y;
                maxDarts = Math.max(maxDarts, countDarts(points, c2x, c2y, R_SQ, EPS));
            }
        }

        return maxDarts;
    }

    // Helper method to count darts within a circle centered at (cx, cy) with radius R
    private int countDarts(int[][] points, double cx, double cy, double R_SQ, double EPS) {
        int count = 0;
        for (int[] p : points) {
            double px = p[0];
            double py = p[1];

            // Calculate squared distance from dart P to center C
            double dist_sq = (px - cx) * (px - cx) + (py - cy) * (py - cy);

            // If squared distance is less than or equal to R_SQ (with tolerance for precision),
            // the dart is inside or on the circumference.
            if (dist_sq <= R_SQ + EPS) {
                count++;
            }
        }
        return count;
    }
}