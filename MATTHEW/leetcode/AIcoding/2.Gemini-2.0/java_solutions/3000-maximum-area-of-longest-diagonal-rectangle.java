class Solution {
    public int areaOfMaxDiagonal(int[][] rectangles) {
        double maxDiagonal = 0;
        int maxArea = 0;

        for (int[] rect : rectangles) {
            int length = rect[0];
            int width = rect[1];
            double diagonal = Math.sqrt(length * length + width * width);

            if (diagonal > maxDiagonal) {
                maxDiagonal = diagonal;
                maxArea = length * width;
            } else if (diagonal == maxDiagonal) {
                maxArea = Math.max(maxArea, length * width);
            }
        }

        return maxArea;
    }
}