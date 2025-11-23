import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int findMinArrowShots(int[][] points) {
        if (points.length == 0) {
            return 0;
        }

        Arrays.sort(points, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                return Integer.compare(a[1], b[1]);
            }
        });

        int arrows = 1;
        int currentArrowShotPoint = points[0][1];

        for (int i = 1; i < points.length; i++) {
            if (points[i][0] > currentArrowShotPoint) {
                arrows++;
                currentArrowShotPoint = points[i][1];
            }
        }

        return arrows;
    }
}