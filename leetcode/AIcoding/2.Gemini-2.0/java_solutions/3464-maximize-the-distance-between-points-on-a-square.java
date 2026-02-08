class Solution {
    public double maxDistance(int[] position) {
        int minX = Integer.MAX_VALUE, maxX = Integer.MIN_VALUE, minY = Integer.MAX_VALUE, maxY = Integer.MIN_VALUE;
        for (int pos : position) {
            int x = pos / 10000;
            int y = pos % 10000;
            minX = Math.min(minX, x);
            maxX = Math.max(maxX, x);
            minY = Math.min(minY, y);
            maxY = Math.max(maxY, y);
        }
        return Math.max(maxX - minX, maxY - minY);
    }
}