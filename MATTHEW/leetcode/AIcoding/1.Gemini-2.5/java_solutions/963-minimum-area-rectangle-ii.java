import java.util.HashSet;
import java.util.Set;

class Solution {
    public double minAreaFreeRect(int[][] points) {
        Set<Long> pointSet = new HashSet<>();
        for (int[] p : points) {
            // Encode point (x, y) into a single long for efficient hashing
            // x is stored in the upper 32 bits, y in the lower 32 bits
            pointSet.add(((long)p[0] << 32) | (p[1] & 0xFFFFFFFFL));
        }

        double minArea = Double.MAX_VALUE;
        int n = points.length;

        // Iterate through all possible combinations of three distinct points (P1, P2, P3)
        // P1 will be considered the vertex with the right angle.
        // P1P2 and P1P3 will be the adjacent sides.
        for (int i = 0; i < n; i++) {
            int x1 = points[i][0];
            int y1 = points[i][1];

            for (int j = 0; j < n; j++) {
                if (i == j) continue; // P1 and P2 must be distinct
                int x2 = points[j][0];
                int y2 = points[j][1];

                for (int k = 0; k < n; k++) {
                    if (k == i || k == j) continue; // P3 must be distinct from P1 and P2
                    int x3 = points[k][0];
                    int y3 = points[k][1];

                    // Calculate vectors P1P2 and P1P3
                    long dx1 = x2 - x1;
                    long dy1 = y2 - y1;
                    long dx2 = x3 - x1;
                    long dy2 = y3 - y1;

                    // Check for perpendicularity: P1P2 . P1P3 == 0
                    // Use long for calculations to prevent overflow, as dx*dx can exceed Integer.MAX_VALUE
                    if (dx1 * dx2 + dy1 * dy2 == 0) {
                        // P1, P2, P3 form a right angle at P1.
                        // The fourth point P4 of the rectangle (P1, P2, P4, P3) can be found by vector addition:
                        // P4 = P2 + (P3 - P1) = (x2 + (x3-x1), y2 + (y3-y1))
                        int x4 = (int)(x2 + dx2);
                        int y4 = (int)(y2 + dy2);

                        long p4Key = ((long)x4 << 32) | (y4 & 0xFFFFFFFFL);

                        // Check if P4 exists in the input set of points
                        if (pointSet.contains(p4Key)) {
                            // Found a rectangle with vertices P1, P2, P4, P3
                            // The sides are P1P2 and P1P3.
                            // Calculate squared lengths of the sides.
                            double side1Sq = (double)(dx1 * dx1 + dy1 * dy1);
                            double side2Sq = (double)(dx2 * dx2 + dy2 * dy2);

                            // The area of the rectangle is |P1P2| * |P1P3|
                            double currentArea = Math.sqrt(side1Sq) * Math.sqrt(side2Sq);

                            // Update minimum area found so far
                            minArea = Math.min(minArea, currentArea);
                        }
                    }
                }
            }
        }

        // If minArea is still Double.MAX_VALUE, no rectangle was found.
        return minArea == Double.MAX_VALUE ? 0.0 : minArea;
    }
}