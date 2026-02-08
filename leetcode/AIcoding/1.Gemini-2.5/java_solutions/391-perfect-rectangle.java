import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean isRectangleCover(int[][] rectangles) {
        if (rectangles == null || rectangles.length == 0 || rectangles[0].length == 0) {
            return false;
        }

        long totalArea = 0;
        int minX = Integer.MAX_VALUE;
        int minY = Integer.MAX_VALUE;
        int maxX = Integer.MIN_VALUE;
        int maxY = Integer.MIN_VALUE;

        Set<String> points = new HashSet<>();

        for (int[] rect : rectangles) {
            int x1 = rect[0];
            int y1 = rect[1];
            int x2 = rect[2];
            int y2 = rect[3];

            minX = Math.min(minX, x1);
            minY = Math.min(minY, y1);
            maxX = Math.max(maxX, x2);
            maxY = Math.max(maxY, y2);

            totalArea += (long)(x2 - x1) * (y2 - y1);

            String p1 = x1 + "," + y1;
            String p2 = x1 + "," + y2;
            String p3 = x2 + "," + y1;
            String p4 = x2 + "," + y2;

            if (!points.add(p1)) {
                points.remove(p1);
            }
            if (!points.add(p2)) {
                points.remove(p2);
            }
            if (!points.add(p3)) {
                points.remove(p3);
            }
            if (!points.add(p4)) {
                points.remove(p4);
            }
        }

        if (points.size() != 4 ||
            !points.contains(minX + "," + minY) ||
            !points.contains(minX + "," + maxY) ||
            !points.contains(maxX + "," + minY) ||
            !points.contains(maxX + "," + maxY)) {
            return false;
        }

        return totalArea == (long)(maxX - minX) * (maxY - minY);
    }
}