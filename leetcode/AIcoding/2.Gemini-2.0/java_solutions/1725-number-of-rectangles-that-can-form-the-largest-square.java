class Solution {
    public int countGoodRectangles(int[][] rectangles) {
        int maxLen = 0;
        int count = 0;
        for (int[] rect : rectangles) {
            int side = Math.min(rect[0], rect[1]);
            if (side > maxLen) {
                maxLen = side;
                count = 1;
            } else if (side == maxLen) {
                count++;
            }
        }
        return count;
    }
}