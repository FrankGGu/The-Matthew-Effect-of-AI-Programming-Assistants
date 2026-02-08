import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int minRectanglesToCoverPoints(int[][] points, int w) {
        Arrays.sort(points, Comparator.comparingInt(p -> p[0]));

        int rectangles = 0;
        int currentCoveredUntilX = -1;

        for (int[] point : points) {
            int x = point[0];

            if (x > currentCoveredUntilX) {
                rectangles++;
                currentCoveredUntilX = x + w;
            }
        }

        return rectangles;
    }
}