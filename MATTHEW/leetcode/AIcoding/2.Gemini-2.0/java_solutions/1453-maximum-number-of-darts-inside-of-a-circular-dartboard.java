class Solution {
    public int numPoints(int[][] points, int r) {
        int n = points.length;
        int ans = 1;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                double dist = Math.sqrt(Math.pow(points[i][0] - points[j][0], 2) + Math.pow(points[i][1] - points[j][1], 2));
                if (dist > 2 * r) continue;
                double midX = (points[i][0] + points[j][0]) / 2.0;
                double midY = (points[i][1] + points[j][1]) / 2.0;
                double d = Math.sqrt(r * r - dist * dist / 4.0);
                double dx = (points[j][1] - points[i][1]) * d / (dist / 2.0);
                double dy = (points[i][0] - points[j][0]) * d / (dist / 2.0);
                double centerX1 = midX + dx;
                double centerY1 = midY + dy;
                double centerX2 = midX - dx;
                double centerY2 = midY - dy;

                int count1 = 0;
                for (int k = 0; k < n; k++) {
                    double dist1 = Math.sqrt(Math.pow(points[k][0] - centerX1, 2) + Math.pow(points[k][1] - centerY1, 2));
                    if (dist1 <= r + 1e-9) count1++;
                }
                ans = Math.max(ans, count1);

                int count2 = 0;
                for (int k = 0; k < n; k++) {
                    double dist2 = Math.sqrt(Math.pow(points[k][0] - centerX2, 2) + Math.pow(points[k][1] - centerY2, 2));
                    if (dist2 <= r + 1e-9) count2++;
                }
                ans = Math.max(ans, count2);
            }
        }
        for(int i=0; i<n; i++){
            int count = 0;
            for(int j=0; j<n; j++){
                double dist = Math.sqrt(Math.pow(points[j][0] - points[i][0], 2) + Math.pow(points[j][1] - points[i][1], 2));
                if(dist <= r + 1e-9) count++;
            }
            ans = Math.max(ans, count);
        }

        return ans;
    }
}