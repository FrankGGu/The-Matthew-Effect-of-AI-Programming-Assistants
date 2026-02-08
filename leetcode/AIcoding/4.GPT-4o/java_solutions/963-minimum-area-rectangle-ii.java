import java.util.HashSet;
import java.util.Set;

public class Solution {
    public double minAreaFreeRect(int[][] points) {
        Set<String> pointSet = new HashSet<>();
        for (int[] p : points) {
            pointSet.add(p[0] + "," + p[1]);
        }
        double minArea = Double.MAX_VALUE;
        int n = points.length;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int[] p1 = points[i];
                int[] p2 = points[j];
                int x1 = p1[0], y1 = p1[1];
                int x2 = p2[0], y2 = p2[1];

                int dx = x2 - x1;
                int dy = y2 - y1;

                int[] p3 = {x1 - dy, y1 + dx};
                int[] p4 = {x2 - dy, y2 + dx};
                if (pointSet.contains(p3[0] + "," + p3[1]) && pointSet.contains(p4[0] + "," + p4[1])) {
                    double area = Math.sqrt(dx * dx + dy * dy) * Math.sqrt(dx * dx + dy * dy);
                    minArea = Math.min(minArea, area);
                }

                p3[0] = x1 + dy;
                p3[1] = y1 - dx;
                p4[0] = x2 + dy;
                p4[1] = y2 - dx;
                if (pointSet.contains(p3[0] + "," + p3[1]) && pointSet.contains(p4[0] + "," + p4[1])) {
                    double area = Math.sqrt(dx * dx + dy * dy) * Math.sqrt(dx * dx + dy * dy);
                    minArea = Math.min(minArea, area);
                }
            }
        }

        return minArea == Double.MAX_VALUE ? 0 : minArea;
    }
}