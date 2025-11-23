class Solution {
    public double getMinDistSum(int[][] positions) {
        double left = 100, bottom = 100, right = 0, top = 0;
        for (int[] pos : positions) {
            left = Math.min(left, pos[0]);
            bottom = Math.min(bottom, pos[1]);
            right = Math.max(right, pos[0]);
            top = Math.max(top, pos[1]);
        }
        double minDist = Double.MAX_VALUE;
        double minX = 0, minY = 0;
        for (double delta = 10; delta >= 0.00001; delta /= 10) {
            for (double x = left; x <= right; x += delta) {
                for (double y = bottom; y <= top; y += delta) {
                    double dist = 0;
                    for (int[] pos : positions) {
                        dist += Math.sqrt((x - pos[0]) * (x - pos[0]) + (y - pos[1]) * (y - pos[1]));
                    }
                    if (dist < minDist) {
                        minDist = dist;
                        minX = x;
                        minY = y;
                    }
                }
            }
            left = minX - delta;
            right = minX + delta;
            bottom = minY - delta;
            top = minY + delta;
        }
        return minDist;
    }
}