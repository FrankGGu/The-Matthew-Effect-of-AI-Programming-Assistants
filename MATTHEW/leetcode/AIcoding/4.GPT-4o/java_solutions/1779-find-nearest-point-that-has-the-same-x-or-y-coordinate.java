class Solution {
    public int[] nearestValidPoint(int x, int y, int[][] points) {
        int minDistance = Integer.MAX_VALUE;
        int[] result = {-1, -1};

        for (int[] point : points) {
            int px = point[0];
            int py = point[1];
            if (px == x || py == y) {
                int distance = Math.abs(px - x) + Math.abs(py - y);
                if (distance < minDistance) {
                    minDistance = distance;
                    result = point;
                }
            }
        }

        return result;
    }
}