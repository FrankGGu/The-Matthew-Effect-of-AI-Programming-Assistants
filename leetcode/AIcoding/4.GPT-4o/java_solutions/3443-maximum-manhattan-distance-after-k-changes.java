class Solution {
    public int manhattanDistance(int[][] points, int k) {
        int maxDistance = 0;
        int n = points.length;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int dx = Math.abs(points[i][0] - points[j][0]);
                int dy = Math.abs(points[i][1] - points[j][1]);
                int distance = dx + dy;
                maxDistance = Math.max(maxDistance, distance);
            }
        }

        return maxDistance + k;
    }
}