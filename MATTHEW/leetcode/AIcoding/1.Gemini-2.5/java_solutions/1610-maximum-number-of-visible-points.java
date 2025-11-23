import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int visiblePoints(List<List<Integer>> points, int angle, List<Integer> position) {
        List<Double> angles = new ArrayList<>();
        int countAtPosition = 0;

        int px = position.get(0);
        int py = position.get(1);

        for (List<Integer> point : points) {
            int x = point.get(0);
            int y = point.get(1);

            if (x == px && y == py) {
                countAtPosition++;
            } else {
                double angleRad = Math.atan2(y - py, x - px);
                double angleDeg = Math.toDegrees(angleRad);
                if (angleDeg < 0) {
                    angleDeg += 360;
                }
                angles.add(angleDeg);
            }
        }

        Collections.sort(angles);

        int n = angles.size();
        for (int i = 0; i < n; i++) {
            angles.add(angles.get(i) + 360);
        }

        int maxVisible = 0;
        int left = 0;
        double givenAngle = (double) angle;

        for (int right = 0; right < angles.size(); right++) {
            while (angles.get(right) - angles.get(left) > givenAngle) {
                left++;
            }
            maxVisible = Math.max(maxVisible, right - left + 1);
        }

        return maxVisible + countAtPosition;
    }
}