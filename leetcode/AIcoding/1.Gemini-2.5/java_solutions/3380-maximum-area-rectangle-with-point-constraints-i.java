class Solution {
    public long maxArea(int[][] points, long maxArea) {
        long maxValidArea = 0L;
        int n = points.length;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int x1 = points[i][0];
                int y1 = points[i][1];
                int x2 = points[j][0];
                int y2 = points[j][1];

                if (x1 > x2 || y1 > y2) {
                    continue;
                }

                boolean allPointsContained = true;
                for (int k = 0; k < n; k++) {
                    int px = points[k][0];
                    int py = points[k][1];

                    if (px < x1 || px > x2 || py < y1 || py > y2) {
                        allPointsContained = false;
                        break;
                    }
                }

                if (allPointsContained) {
                    long currentArea = (long) (x2 - x1) * (y2 - y1);
                    if (currentArea <= maxArea) {
                        maxValidArea = Math.max(maxValidArea, currentArea);
                    }
                }
            }
        }

        return maxValidArea;
    }
}