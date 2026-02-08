import java.util.Arrays;

class Solution {
    public int minAreaRectangles(int[][] points) {
        int n = points.length;
        if (n < 4) return 0;

        Arrays.sort(points, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        int minArea = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (points[i][0] == points[j][0]) continue;
                for (int k = j + 1; k < n; k++) {
                    if (points[k][0] == points[j][0]) continue;
                    if (points[k][1] == points[j][1]) {
                        for(int l = k + 1; l < n; l++) {
                            if (points[l][0] == points[i][0] && points[l][1] == points[k][1]) {
                                int area = Math.abs(points[i][0] - points[j][0]) * Math.abs(points[j][1] - points[k][1]);
                                minArea = Math.min(minArea, area);
                            }
                        }
                    }
                }
            }
        }

        return minArea == Integer.MAX_VALUE ? 0 : minArea;
    }
}