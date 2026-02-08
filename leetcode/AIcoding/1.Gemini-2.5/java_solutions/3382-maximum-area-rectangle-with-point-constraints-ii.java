import java.util.*;

class Solution {

    // Helper class to represent a point
    static class Point {
        int x, y; // Original coordinates
        int compressedX, compressedY; // Compressed coordinates

        Point(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }

    public long maxArea(int[][] pointsArray, int k) {
        if (pointsArray == null || pointsArray.length < k) {
            return 0;
        }

        List<Point> points = new ArrayList<>();
        for (int[] p : pointsArray) {
            points.add(new Point(p[0], p[1]));
        }

        // 1. Coordinate Compression: Map original coordinates to smaller, contiguous integers.
        // This helps in using arrays/TreeMaps with indices.
        Set<Integer> xCoordsSet = new TreeSet<>();
        Set<Integer> yCoordsSet = new TreeSet<>();
        for (Point p : points) {
            xCoordsSet.add(p.x);
            yCoordsSet.add(p.y);
        }

        List<Integer> distinctX = new ArrayList<>(xCoordsSet);
        List<Integer> distinctY = new ArrayList<>(yCoordsSet);

        Map<Integer, Integer> xMap = new HashMap<>();
        for (int i = 0; i < distinctX.size(); i++) {
            xMap.put(distinctX.get(i), i);
        }

        Map<Integer, Integer> yMap = new HashMap<>();
        for (int i = 0; i < distinctY.size(); i++) {
            yMap.put(distinctY.get(i), i);
        }

        // Assign compressed coordinates to points
        for (Point p : points) {
            p.compressedX = xMap.get(p.x);
            p.compressedY = yMap.get(p.y);
        }

        // 2. Group points by their compressed X-coordinate for efficient sweep-line processing.
        List<Point>[] pointsByCompressedX = new List[distinctX.size()];
        for (int i = 0; i < distinctX.size(); i++) {
            pointsByCompressedX[i] = new ArrayList<>();
        }
        for (Point p : points) {
            pointsByCompressedX[p.compressedX].add(p);
        }

        long maxArea = 0;

        // 3. Sweep-line Algorithm: Iterate over all possible pairs of left and right X-boundaries.
        // The outer loop fixes the left X-boundary (x1).
        for (int i = 0; i < distinctX.size(); i++) {
            int x1 = distinctX.get(i); // Original X-coordinate for the left boundary

            // TreeMap to store counts of points for the current vertical strip [x1, x2].
            // Key: compressed Y-coordinate, Value: count of points at this Y-coordinate.
            // TreeMap keeps keys sorted, which is crucial for the sliding window.
            TreeMap<Integer, Integer> yCounts = new TreeMap<>();

            // The inner loop extends the right X-boundary (x2).
            for (int j = i; j < distinctX.size(); j++) {
                int x2 = distinctX.get(j); // Original X-coordinate for the right boundary

                // Add all points whose compressed X-coordinate is 'j' to the TreeMap.
                // These points are now part of the current vertical strip.
                for (Point p : pointsByCompressedX[j]) {
                    yCounts.put(p.compressedY, yCounts.getOrDefault(p.compressedY, 0) + 1);
                }

                // If the total number of points in the current strip is less than K,
                // no rectangle can contain exactly K points, so continue.
                if (yCounts.isEmpty() || yCounts.values().stream().mapToInt(Integer::intValue).sum() < k) {
                    continue;
                }

                // 4. Sliding Window on Y-coordinates:
                // For the fixed X-boundaries [x1, x2], find the maximum height (y2 - y1)
                // such that the rectangle contains exactly K points.

                // Get all distinct compressed Y-coordinates present in the current strip, in sorted order.
                List<Integer> distinctYInStrip = new ArrayList<>(yCounts.keySet());

                int currentPointsCount = 0; // Count of points in the current Y-window
                int bottomPtr = 0;          // Pointer for the bottom of the Y-window (index in distinctYInStrip)

                // The topPtr iterates through all possible top Y-coordinates.
                for (int topPtr = 0; topPtr < distinctYInStrip.size(); topPtr++) {
                    // Expand the window by including points at distinctYInStrip.get(topPtr)
                    currentPointsCount += yCounts.get(distinctYInStrip.get(topPtr));

                    // Shrink the window from the bottom if the count exceeds K.
                    // We remove points from the bottom until the count is <= K.
                    while (currentPointsCount > k && bottomPtr <= topPtr) {
                        currentPointsCount -= yCounts.get(distinctYInStrip.get(bottomPtr));
                        bottomPtr++;
                    }

                    // If the current window contains exactly K points, calculate its area and update maxArea.
                    if (currentPointsCount == k) {
                        int y1_original = distinctY.get(distinctYInStrip.get(bottomPtr));
                        int y2_original = distinctY.get(distinctYInStrip.get(topPtr));
                        long currentArea = (long) (x2 - x1) * (y2_original - y1_original);
                        maxArea = Math.max(maxArea, currentArea);
                    }
                }
            }
        }

        return maxArea;
    }
}