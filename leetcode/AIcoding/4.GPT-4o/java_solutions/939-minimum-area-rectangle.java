import java.util.HashSet;

public class Solution {
    public int minAreaRect(int[][] points) {
        HashSet<Integer> set = new HashSet<>();
        for (int[] point : points) {
            set.add(point[0] * 10001 + point[1]);
        }

        int minArea = Integer.MAX_VALUE;
        for (int i = 0; i < points.length; i++) {
            for (int j = i + 1; j < points.length; j++) {
                if (points[i][0] != points[j][0] && points[i][1] != points[j][1]) {
                    if (set.contains(points[i][0] * 10001 + points[j][1]) &&
                        set.contains(points[j][0] * 10001 + points[i][1])) {
                        int area = Math.abs(points[i][0] - points[j][0]) * Math.abs(points[i][1] - points[j][1]);
                        minArea = Math.min(minArea, area);
                    }
                }
            }
        }
        return minArea == Integer.MAX_VALUE ? 0 : minArea;
    }
}