class Solution {
    public int countGoodRectangles(int[][] rectangles) {
        int maxLen = 0;
        int count = 0;
        for (int[] rect : rectangles) {
            int current = Math.min(rect[0], rect[1]);
            if (current > maxLen) {
                maxLen = current;
                count = 1;
            } else if (current == maxLen) {
                count++;
            }
        }
        return count;
    }
}