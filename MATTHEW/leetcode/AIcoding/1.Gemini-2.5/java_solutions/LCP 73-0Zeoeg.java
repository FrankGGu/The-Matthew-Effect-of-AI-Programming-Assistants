import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

class Solution {
    public int solve(int[][] points, int k) {
        if (points == null || points.length == 0 || k < 0) {
            return 0;
        }

        Arrays.sort(points, (a, b) -> Integer.compare(a[0], b[0]));

        int maxPoints = 0;
        int n = points.length;

        for (int i = 0; i < n; ++i) {
            List<int[]> currentXStrip = new ArrayList<>();
            for (int j = i; j < n; ++j) {
                if (points[j][0] <= points[i][0] + k) {
                    currentXStrip.add(points[j]);
                } else {
                    break;
                }
            }

            currentXStrip.sort((a, b) -> Integer.compare(a[1], b[1]));

            int currentYLeft = 0;
            for (int currentYRight = 0; currentYRight < currentXStrip.size(); ++currentYRight) {
                while (currentXStrip.get(currentYRight)[1] - currentXStrip.get(currentYLeft)[1] > k) {
                    currentYLeft++;
                }
                maxPoints = Math.max(maxPoints, currentYRight - currentYLeft + 1);
            }
        }

        return maxPoints;
    }
}