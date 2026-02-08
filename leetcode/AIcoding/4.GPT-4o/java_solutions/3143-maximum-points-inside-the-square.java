class Solution {
    public int maxPoints(int[][] points, int size) {
        int maxCount = 0;
        for (int[] point : points) {
            int count = 0;
            int x1 = point[0], y1 = point[1];
            for (int[] p : points) {
                if (p[0] >= x1 && p[0] <= x1 + size && p[1] >= y1 && p[1] <= y1 + size) {
                    count++;
                }
            }
            maxCount = Math.max(maxCount, count);
        }
        return maxCount;
    }
}