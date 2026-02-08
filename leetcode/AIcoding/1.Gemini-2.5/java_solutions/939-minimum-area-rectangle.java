import java.util.HashSet;
import java.util.Set;

class Solution {
    public int minAreaRect(int[][] points) {
        Set<Integer> pointSet = new HashSet<>();
        // A constant larger than the maximum possible Y coordinate to encode points
        // Max Y is 40000, so 40001 ensures unique encoding for (x,y)
        final int M = 40001; 

        for (int[] p : points) {
            pointSet.add(p[0] * M + p[1]);
        }

        int minArea = Integer.MAX_VALUE;

        for (int i = 0; i < points.length; i++) {
            for (int j = i + 1; j < points.length; j++) {
                int x1 = points[i][0];
                int y1 = points[i][1];
                int x2 = points[j][0];
                int y2 = points[j][1];

                // If points share an x-coordinate or a y-coordinate,
                // they cannot be diagonal corners of a rectangle with non-zero area
                // whose sides are parallel to the axes.
                if (x1 == x2 || y1 == y2) {
                    continue;
                }

                // For points (x1, y1) and (x2, y2) to be diagonal corners of a rectangle,
                // the other two corners must be (x1, y2) and (x2, y1).
                // Check if these two potential corners exist in the set of points.
                if (pointSet.contains(x1 * M + y2) && pointSet.contains(x2 * M + y1)) {
                    int currentArea = Math.abs(x2 - x1) * Math.abs(y2 - y1);
                    minArea = Math.min(minArea, currentArea);
                }
            }
        }

        // If minArea is still Integer.MAX_VALUE, no rectangle was found.
        return minArea == Integer.MAX_VALUE ? 0 : minArea;
    }
}