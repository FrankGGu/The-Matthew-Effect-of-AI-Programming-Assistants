class Solution {
    public int largestArea(int[][] rectangles) {
        int minX2 = Integer.MAX_VALUE;
        int minY2 = Integer.MAX_VALUE;
        int maxX1 = Integer.MIN_VALUE;
        int maxY1 = Integer.MIN_VALUE;

        for (int[] rect : rectangles) {
            int x1 = rect[0];
            int y1 = rect[1];
            int x2 = rect[2];
            int y2 = rect[3];

            maxX1 = Math.max(maxX1, x1);
            maxY1 = Math.max(maxY1, y1);
            minX2 = Math.min(minX2, x2);
            minY2 = Math.min(minY2, y2);
        }

        int side = Math.min(minX2 - maxX1, minY2 - maxY1);

        if (side <= 0) {
            return 0;
        }

        return side * side;
    }
}