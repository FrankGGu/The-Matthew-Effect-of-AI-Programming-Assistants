public class Solution {

import java.util.*;

public class Solution {
    public int maxPointsInsideSquare(int[] points, int[] s) {
        int n = points.length;
        int[] x = new int[n];
        int[] y = new int[n];
        for (int i = 0; i < n; i++) {
            x[i] = points[2 * i];
            y[i] = points[2 * i + 1];
        }

        int[] dist = new int[n];
        for (int i = 0; i < n; i++) {
            dist[i] = Math.abs(x[i]) + Math.abs(y[i]);
        }

        Arrays.sort(dist);

        int count = 0;
        for (int i = 0; i < n; i++) {
            if (i == 0 || dist[i] != dist[i - 1]) {
                count++;
            } else {
                return 0;
            }
        }

        return count;
    }
}
}