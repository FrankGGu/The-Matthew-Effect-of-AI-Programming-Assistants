import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int maxVisiblePoints(List<List<Integer>> points, int angle, List<Integer> location) {
        int same = 0;
        List<Double> angles = new ArrayList<>();
        int x0 = location.get(0), y0 = location.get(1);
        for (List<Integer> p : points) {
            int x = p.get(0), y = p.get(1);
            if (x == x0 && y == y0) {
                same++;
            } else {
                double theta = Math.atan2(y - y0, x - x0) * 180 / Math.PI;
                angles.add(theta);
            }
        }
        Collections.sort(angles);
        int n = angles.size();
        for (int i = 0; i < n; ++i) {
            angles.add(angles.get(i) + 360);
        }
        int maxPoints = 0;
        int left = 0;
        for (int right = 0; right < angles.size(); ++right) {
            while (angles.get(right) - angles.get(left) > angle) {
                left++;
            }
            maxPoints = Math.max(maxPoints, right - left + 1);
        }
        return maxPoints + same;
    }
}