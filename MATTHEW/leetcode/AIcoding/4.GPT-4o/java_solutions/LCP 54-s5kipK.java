class Solution {
    public int capturePoints(int[][] points) {
        int n = points.length;
        int result = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (points[i][0] == points[j][0] || points[i][1] == points[j][1]) {
                    result++;
                }
            }
        }
        return result;
    }
}