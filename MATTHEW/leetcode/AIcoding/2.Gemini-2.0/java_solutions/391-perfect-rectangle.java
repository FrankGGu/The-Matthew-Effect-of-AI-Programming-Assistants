import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean isRectangleCover(int[][] rectangles) {
        if (rectangles == null || rectangles.length == 0) {
            return true;
        }

        int area = 0;
        int minX = Integer.MAX_VALUE;
        int minY = Integer.MAX_VALUE;
        int maxX = Integer.MIN_VALUE;
        int maxY = Integer.MIN_VALUE;

        Set<String> corners = new HashSet<>();

        for (int[] rect : rectangles) {
            int x1 = rect[0];
            int y1 = rect[1];
            int x2 = rect[2];
            int y2 = rect[3];

            area += (x2 - x1) * (y2 - y1);

            minX = Math.min(minX, x1);
            minY = Math.min(minY, y1);
            maxX = Math.max(maxX, x2);
            maxY = Math.max(maxY, y2);

            String s1 = x1 + " " + y1;
            String s2 = x1 + " " + y2;
            String s3 = x2 + " " + y1;
            String s4 = x2 + " " + y2;

            if (!corners.add(s1)) corners.remove(s1);
            if (!corners.add(s2)) corners.remove(s2);
            if (!corners.add(s3)) corners.remove(s3);
            if (!corners.add(s4)) corners.remove(s4);
        }

        if (corners.size() != 4) {
            return false;
        }

        if (!corners.contains(minX + " " + minY) ||
            !corners.contains(minX + " " + maxY) ||
            !corners.contains(maxX + " " + minY) ||
            !corners.contains(maxX + " " + maxY)) {
            return false;
        }

        return area == (maxX - minX) * (maxY - minY);
    }
}