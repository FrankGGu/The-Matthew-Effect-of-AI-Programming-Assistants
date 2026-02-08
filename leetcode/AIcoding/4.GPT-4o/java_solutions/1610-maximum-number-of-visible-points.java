import java.util.*;

class Solution {
    public int visiblePoints(List<List<Integer>> points, int angle, List<Integer> location) {
        List<Double> angles = new ArrayList<>();
        int locationX = location.get(0);
        int locationY = location.get(1);

        for (List<Integer> point : points) {
            double dx = point.get(0) - locationX;
            double dy = point.get(1) - locationY;
            angles.add(Math.atan2(dy, dx));
        }

        Collections.sort(angles);
        int n = angles.size();
        for (int i = 0; i < n; i++) {
            angles.add(angles.get(i) + 2 * Math.PI);
        }

        double angleInRad = Math.toRadians(angle);
        int maxVisible = 0;
        int j = 0;

        for (int i = 0; i < n; i++) {
            while (j < angles.size() && angles.get(j) - angles.get(i) <= angleInRad) {
                j++;
            }
            maxVisible = Math.max(maxVisible, j - i);
        }

        return maxVisible;
    }
}