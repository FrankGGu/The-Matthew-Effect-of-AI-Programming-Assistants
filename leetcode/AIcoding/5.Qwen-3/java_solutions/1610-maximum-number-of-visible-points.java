public class Solution {

import java.util.*;

public class Solution {
    public int visiblePoints(List<List<Integer>> points, int angle) {
        List<Double> angles = new ArrayList<>();
        int base = 0;
        for (List<Integer> point : points) {
            int x = point.get(0);
            int y = point.get(1);
            if (x == 0 && y == 0) {
                base++;
                continue;
            }
            double rad = Math.atan2(y, x);
            angles.add(rad);
        }
        Collections.sort(angles);
        int n = angles.size();
        for (int i = 0; i < n; i++) {
            angles.add(angles.get(i) + 2 * Math.PI);
        }
        int max = 0;
        int j = 0;
        for (int i = 0; i < n; i++) {
            while (j < 2 * n && angles.get(j) - angles.get(i) <= angle * Math.PI / 180) {
                j++;
            }
            max = Math.max(max, j - i);
        }
        return max + base;
    }
}
}