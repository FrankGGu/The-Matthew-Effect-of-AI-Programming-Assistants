class Solution {
    public int countGoodRectangles(int[][] rectangles) {
        int maxLength = 0;
        int count = 0;

        for (int[] rectangle : rectangles) {
            int side = Math.min(rectangle[0], rectangle[1]);
            if (side > maxLength) {
                maxLength = side;
                count = 1;
            } else if (side == maxLength) {
                count++;
            }
        }

        return count;
    }
}