public class Solution {
    public int maxSquareArea(int[] rect1, int[] rect2) {
        int maxLength = 0;
        for (int i = 0; i < 2; i++) {
            int width1 = rect1[i * 2 + 2] - rect1[i * 2];
            int height1 = rect1[i * 2 + 3] - rect1[i * 2 + 1];
            int width2 = rect2[i * 2 + 2] - rect2[i * 2];
            int height2 = rect2[i * 2 + 3] - rect2[i * 2 + 1];

            for (int x = Math.max(rect1[i * 2], rect2[i * 2]); x < Math.min(rect1[i * 2 + 2], rect2[i * 2 + 2]); x++) {
                for (int y = Math.max(rect1[i * 2 + 1], rect2[i * 2 + 1]); y < Math.min(rect1[i * 2 + 3], rect2[i * 2 + 3]); y++) {
                    maxLength = Math.max(maxLength, Math.min(width1, height1));
                    maxLength = Math.max(maxLength, Math.min(width2, height2));
                }
            }
        }
        return maxLength * maxLength;
    }
}