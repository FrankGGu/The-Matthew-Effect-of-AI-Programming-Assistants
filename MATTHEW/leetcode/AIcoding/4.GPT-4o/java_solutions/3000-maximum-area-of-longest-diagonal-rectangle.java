class Solution {
    public int maxArea(int[][] rectangles) {
        int maxArea = 0;
        for (int[] rect : rectangles) {
            maxArea = Math.max(maxArea, rect[0] * rect[1]);
        }
        return maxArea;
    }
}