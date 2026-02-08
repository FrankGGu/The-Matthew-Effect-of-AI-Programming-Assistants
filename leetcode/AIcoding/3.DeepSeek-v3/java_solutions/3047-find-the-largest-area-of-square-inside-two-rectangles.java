class Solution {
    public int largestSquareArea(int[][] rectangles) {
        int maxArea = 0;
        for (int i = 0; i < rectangles.length; i++) {
            for (int j = i + 1; j < rectangles.length; j++) {
                int x1 = Math.max(rectangles[i][0], rectangles[j][0]);
                int y1 = Math.max(rectangles[i][1], rectangles[j][1]);
                int x2 = Math.min(rectangles[i][2], rectangles[j][2]);
                int y2 = Math.min(rectangles[i][3], rectangles[j][3]);
                if (x1 < x2 && y1 < y2) {
                    int side = Math.min(x2 - x1, y2 - y1);
                    maxArea = Math.max(maxArea, side * side);
                }
            }
        }
        return maxArea;
    }
}