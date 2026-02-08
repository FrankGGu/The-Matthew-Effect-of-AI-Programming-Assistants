import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maxPoints(int[][] points) {
        int n = points.length;
        if (n <= 2) {
            return n;
        }

        int maxPoints = 0;

        // Iterate through each point as a reference point p1
        for (int i = 0; i < n; i++) {
            int[] p1 = points[i];

            // Map to store slopes (as normalized dy/dx strings) and their counts
            // for lines passing through p1.
            Map<String, Integer> slopes = new HashMap<>();

            int overlap = 0; // Count of points identical to p1
            // currentMax stores the maximum number of *other distinct points*
            // that form a line with p1.
            int currentMax = 0; 

            // Iterate through subsequent points p2 to form lines with p1
            for (int j = i + 1; j < n; j++) {
                int[] p2 = points[j];

                // Handle duplicate points: if p1 and p2 are identical
                if (p1[0] == p2[0] && p1[1] == p2[1]) {
                    overlap++;
                    continue; // Skip to the next point
                }

                int dy = p2[1] - p1[1];
                int dx = p2[0] - p1[0];

                // Calculate GCD to normalize the slope (dy, dx)
                // This prevents floating-point precision issues and ensures unique slope representation
                int common = gcd(dy, dx);
                dy /= common;
                dx /= common;

                // Canonical form for slope (dy, dx):
                // Ensure dx is non-negative. If dx is 0, ensure dy is positive.
                // This guarantees a unique string key for each slope.
                if (dx < 0 || (dx == 0 && dy < 0)) {
                    dx = -dx;
                    dy = -dy;
                }

                String key = dy + "/" + dx;
                slopes.put(key, slopes.getOrDefault(key, 0) + 1);
                currentMax = Math.max(currentMax, slopes.get(key));
            }

            // The total number of points on the line is:
            // currentMax (other distinct points) + overlap (identical points) + 1 (for p1 itself)
            maxPoints = Math.max(maxPoints, currentMax + overlap + 1);
        }

        return maxPoints;
    }

    // Euclidean algorithm to find the Greatest Common Divisor (GCD)
    // Ensures a non-negative GCD.
    private int gcd(int a, int b) {
        // Take absolute values to handle negative coordinates and differences correctly
        a = Math.abs(a);
        b = Math.abs(b);

        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}