public class Solution {

import java.util.*;

public class Solution {
    public int maxDistance(int[][] points) {
        int n = points.length;
        int maxDist = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int dx = Math.abs(points[i][0] - points[j][0]);
                int dy = Math.abs(points[i][1] - points[j][1]);
                maxDist = Math.max(maxDist, dx + dy);
            }
        }
        return maxDist;
    }
}
}