import java.util.*;

class Solution {
    public double minAreaFreeRect(int[][] points) {
        int n = points.length;
        double minArea = Double.MAX_VALUE;
        Map<Double, List<int[]>> map = new HashMap<>();

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int x1 = points[i][0], y1 = points[i][1];
                int x2 = points[j][0], y2 = points[j][1];
                double dist = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
                double midX = (x1 + x2) / 2.0;
                double midY = (y1 + y2) / 2.0;
                double key = dist + midX * 1e-6 + midY * 1e-12; 

                map.computeIfAbsent(key, k -> new ArrayList<>()).add(new int[]{i, j});
            }
        }

        for (List<int[]> list : map.values()) {
            for (int i = 0; i < list.size(); i++) {
                for (int j = i + 1; j < list.size(); j++) {
                    int p1 = list.get(i)[0], p2 = list.get(i)[1];
                    int p3 = list.get(j)[0], p4 = list.get(j)[1];

                    int x1 = points[p1][0], y1 = points[p1][1];
                    int x2 = points[p2][0], y2 = points[p2][1];
                    int x3 = points[p3][0], y3 = points[p3][1];
                    int x4 = points[p4][0], y4 = points[p4][1];

                    double side1 = Math.sqrt((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3));
                    double side2 = Math.sqrt((x1 - x4) * (x1 - x4) + (y1 - y4) * (y1 - y4));
                    double area = side1 * side2;

                    if (area > 0) {
                        minArea = Math.min(minArea, area);
                    }
                }
            }
        }

        return minArea == Double.MAX_VALUE ? 0 : minArea;
    }
}