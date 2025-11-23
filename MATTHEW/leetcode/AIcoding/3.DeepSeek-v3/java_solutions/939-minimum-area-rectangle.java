import java.util.*;

class Solution {
    public int minAreaRect(int[][] points) {
        Map<Integer, Set<Integer>> map = new HashMap<>();
        for (int[] point : points) {
            int x = point[0], y = point[1];
            map.computeIfAbsent(x, k -> new HashSet<>()).add(y);
        }

        int minArea = Integer.MAX_VALUE;
        for (int i = 0; i < points.length; i++) {
            for (int j = i + 1; j < points.length; j++) {
                int[] p1 = points[i];
                int[] p2 = points[j];
                if (p1[0] == p2[0] || p1[1] == p2[1]) {
                    continue;
                }
                if (map.get(p1[0]).contains(p2[1]) && map.get(p2[0]).contains(p1[1])) {
                    int area = Math.abs(p1[0] - p2[0]) * Math.abs(p1[1] - p2[1]);
                    minArea = Math.min(minArea, area);
                }
            }
        }
        return minArea == Integer.MAX_VALUE ? 0 : minArea;
    }
}