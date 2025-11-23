import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

class Solution {
    static class Point {
        int x;
        int y;

        Point(int x, int y) {
            this.x = x;
            this.y = y;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Point point = (Point) o;
            return x == point.x && y == point.y;
        }

        @Override
        public int hashCode() {
            return Objects.hash(x, y);
        }
    }

    public int longestVShapedDiagonalSegment(int[][] pointsArray) {
        Set<Point> pointSet = new HashSet<>();
        for (int[] p : pointsArray) {
            pointSet.add(new Point(p[0], p[1]));
        }

        int maxLen = 0;

        for (int i = 0; i < pointsArray.length; i++) {
            Point p1 = new Point(pointsArray[i][0], pointsArray[i][1]);
            for (int j = 0; j < pointsArray.length; j++) {
                if (i == j) {
                    continue;
                }
                Point p2 = new Point(pointsArray[j][0], pointsArray[j][1]);

                int x1 = p1.x;
                int y1 = p1.y;
                int x2 = p2.x;
                int y2 = p2.y;

                if (x1 >= x2) {
                    continue;
                }

                int k = x2 - x1;

                if (Math.abs(y2 - y1) != k) {
                    continue;
                }

                Point p3Candidate = new Point(x1 + 2 * k, y1);

                if (pointSet.contains(p3Candidate)) {
                    maxLen = Math.max(maxLen, 2 * k);
                }
            }
        }

        return maxLen;
    }
}