import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int visiblePoints(List<List<Integer>> points, int angle, List<Integer> location) {
        int x = location.get(0), y = location.get(1);
        List<Double> angles = new ArrayList<>();
        int same = 0;

        for (List<Integer> point : points) {
            int dx = point.get(0) - x;
            int dy = point.get(1) - y;
            if (dx == 0 && dy == 0) {
                same++;
                continue;
            }
            double theta = Math.atan2(dy, dx) * 180 / Math.PI;
            angles.add(theta);
        }

        Collections.sort(angles);
        int n = angles.size();
        for (int i = 0; i < n; i++) {
            angles.add(angles.get(i) + 360);
        }

        int max = 0;
        int right = 0;
        for (int left = 0; left < n; left++) {
            while (right < angles.size() && angles.get(right) - angles.get(left) <= angle) {
                right++;
            }
            max = Math.max(max, right - left);
        }

        return max + same;
    }
}