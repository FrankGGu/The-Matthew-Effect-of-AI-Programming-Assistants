public class Solution {
    public int largestSquare(int[][] rectangles) {
        int maxSide = 0;
        int count = 0;

        for (int[] rect : rectangles) {
            int side = Math.min(rect[0], rect[1]);
            if (side > maxSide) {
                maxSide = side;
                count = 1;
            } else if (side == maxSide) {
                count++;
            }
        }

        return count;
    }
}