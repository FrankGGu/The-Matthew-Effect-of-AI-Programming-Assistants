public class Solution {

import java.util.*;

public class Solution {
    public int[] countPoints(int[][] points, int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int x = queries[i][0];
            int y = queries[i][1];
            int r = queries[i][2];
            int count = 0;
            for (int j = 0; j < points.length; j++) {
                int px = points[j][0];
                int py = points[j][1];
                if ((px - x) * (px - x) + (py - y) * (py - y) <= r * r) {
                    count++;
                }
            }
            result[i] = count;
        }
        return result;
    }
}
}