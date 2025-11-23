import java.util.*;

public class Solution {
    public int[] countRectangles(int[][] rectangles, int[][] points) {
        int n = rectangles.length;
        int m = points.length;
        int[] result = new int[m];

        Arrays.sort(rectangles, (a, b) -> Integer.compare(a[1], b[1]));

        for (int i = 0; i < m; i++) {
            int x = points[i][0];
            int y = points[i][1];
            int count = 0;

            for (int[] rectangle : rectangles) {
                if (rectangle[0] >= x && rectangle[1] >= y) {
                    count++;
                }
            }
            result[i] = count;
        }

        return result;
    }
}