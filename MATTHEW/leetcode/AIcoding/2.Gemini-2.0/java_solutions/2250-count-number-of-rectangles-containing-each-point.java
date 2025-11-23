import java.util.Arrays;

class Solution {
    public int[] countRectangles(int[][] rectangles, int[][] points) {
        Arrays.sort(rectangles, (a, b) -> Integer.compare(b[0], a[0]));
        int[] result = new int[points.length];
        for (int i = 0; i < points.length; i++) {
            int count = 0;
            for (int[] rect : rectangles) {
                if (rect[0] >= points[i][0] && rect[1] >= points[i][1]) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
}