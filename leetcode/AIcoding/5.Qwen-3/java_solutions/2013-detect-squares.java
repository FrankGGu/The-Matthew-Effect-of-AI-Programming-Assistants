public class Solution {

import java.util.*;

public class DetectSquares {
    private Map<String, Integer> pointCount = new HashMap<>();
    private List<int[]> points = new ArrayList<>();

    public void add(int[] point) {
        String key = point[0] + "," + point[1];
        pointCount.put(key, pointCount.getOrDefault(key, 0) + 1);
        points.add(point);
    }

    public void remove(int[] point) {
        String key = point[0] + "," + point[1];
        if (pointCount.get(key) == 1) {
            pointCount.remove(key);
        } else {
            pointCount.put(key, pointCount.get(key) - 1);
        }
    }

    public int count(int[] point) {
        int x1 = point[0];
        int y1 = point[1];
        int count = 0;

        for (int[] p : points) {
            int x2 = p[0];
            int y2 = p[1];
            if (x1 == x2 || y1 == y2) continue;
            if (Math.abs(x1 - x2) == Math.abs(y1 - y2)) {
                int x3 = x2;
                int y3 = y1;
                int x4 = x1;
                int y4 = y2;
                String key1 = x2 + "," + y2;
                String key2 = x3 + "," + y3;
                String key3 = x4 + "," + y4;
                int c1 = pointCount.getOrDefault(key1, 0);
                int c2 = pointCount.getOrDefault(key2, 0);
                int c3 = pointCount.getOrDefault(key3, 0);
                count += c1 * c2 * c3;
            }
        }

        return count;
    }
}
}