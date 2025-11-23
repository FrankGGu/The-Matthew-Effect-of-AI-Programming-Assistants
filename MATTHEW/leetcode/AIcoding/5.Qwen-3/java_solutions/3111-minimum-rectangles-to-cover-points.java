public class Solution {

import java.util.*;

public class Solution {
    public int minRectanglesToCoverPoints(int[][] points, int w) {
        Arrays.sort(points, (a, b) -> a[0] - b[0]);
        int count = 0;
        int i = 0;
        while (i < points.length) {
            int x = points[i][0];
            int j = i;
            while (j < points.length && points[j][0] <= x + w) {
                j++;
            }
            count++;
            i = j;
        }
        return count;
    }
}
}