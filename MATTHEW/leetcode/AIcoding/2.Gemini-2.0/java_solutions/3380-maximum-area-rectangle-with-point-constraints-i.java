import java.util.Arrays;

class Solution {
    public int solve(int[][] points, int w, int h) {
        Arrays.sort(points, (a, b) -> a[0] - b[0]);
        int maxArea = 0;
        for (int i = 0; i < points.length; i++) {
            for (int j = i; j < points.length; j++) {
                int x1 = points[i][0];
                int x2 = points[j][0];
                if (x2 - x1 > w) continue;
                int minY = 0, maxY = h;
                for (int k = 0; k < points.length; k++) {
                    if (points[k][0] >= x1 && points[k][0] <= x2) {
                        minY = Math.max(minY, points[k][1]);
                    }
                }
                if (minY == 0) continue;

                for (int k = 0; k < points.length; k++) {
                    if (points[k][0] >= x1 && points[k][0] <= x2) {
                        maxY = Math.min(maxY, points[k][1]);
                    }
                }

                if (maxY <= minY) continue;

                maxArea = Math.max(maxArea, (x2 - x1) * (maxY - minY));
            }
        }
        return maxArea;
    }
}