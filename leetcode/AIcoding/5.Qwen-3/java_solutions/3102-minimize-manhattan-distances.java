public class Solution {

import java.util.*;

public class Solution {
    public int minimumDistance(int[][] points) {
        int n = points.length;
        int minDist = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int dist = Math.abs(points[i][0] - points[j][0]) + Math.abs(points[i][1] - points[j][1]);
                minDist = Math.min(minDist, dist);
            }
        }

        return minDist;
    }
}
}