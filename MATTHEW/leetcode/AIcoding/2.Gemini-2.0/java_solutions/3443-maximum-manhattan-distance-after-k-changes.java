class Solution {
    public int maxManhattan(int[][] points, int k) {
        int n = points.length;
        int max1 = Integer.MIN_VALUE, min1 = Integer.MAX_VALUE;
        int max2 = Integer.MIN_VALUE, min2 = Integer.MAX_VALUE;

        for (int[] point : points) {
            int x = point[0], y = point[1];
            max1 = Math.max(max1, x + y);
            min1 = Math.min(min1, x + y);
            max2 = Math.max(max2, x - y);
            min2 = Math.min(min2, x - y);
        }

        int ans = Math.max(max1 - min1, max2 - min2);
        return ans + k;
    }
}