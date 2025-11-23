class Solution {
    public int maxPoints(int[][] points) {
        int n = points.length;
        if (n < 3) return n;

        int maxPoints = 2;

        for (int i = 0; i < n; i++) {
            Map<Double, Integer> slopeCount = new HashMap<>();
            for (int j = i + 1; j < n; j++) {
                double slope = points[i][0] == points[j][0] ? Double.POSITIVE_INFINITY :
                        (double) (points[j][1] - points[i][1]) / (points[j][0] - points[i][0]);
                slopeCount.put(slope, slopeCount.getOrDefault(slope, 1) + 1);
            }
            for (int count : slopeCount.values()) {
                maxPoints = Math.max(maxPoints, count);
            }
        }

        return maxPoints;
    }
}