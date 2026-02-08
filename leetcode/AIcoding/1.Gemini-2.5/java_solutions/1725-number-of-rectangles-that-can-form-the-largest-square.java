class Solution {
    public int countGoodRectangles(int[][] rectangles) {
        int maxSide = 0;
        int count = 0;

        for (int[] rect : rectangles) {
            int currentSide = Math.min(rect[0], rect[1]);
            if (currentSide > maxSide) {
                maxSide = currentSide;
                count = 1;
            } else if (currentSide == maxSide) {
                count++;
            }
        }

        return count;
    }
}