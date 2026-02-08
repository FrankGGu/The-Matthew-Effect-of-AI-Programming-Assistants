import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int rectangleArea(int[][] rectangles) {
        List<Integer> xValues = new ArrayList<>();
        for (int[] rect : rectangles) {
            xValues.add(rect[0]);
            xValues.add(rect[2]);
        }
        Collections.sort(xValues);

        long totalArea = 0;
        for (int i = 0; i < xValues.size() - 1; i++) {
            int x1 = xValues.get(i);
            int x2 = xValues.get(i + 1);
            if (x1 == x2) continue;

            List<int[]> intervals = new ArrayList<>();
            for (int[] rect : rectangles) {
                if (rect[0] <= x1 && x2 <= rect[2]) {
                    intervals.add(new int[]{rect[1], rect[3]});
                }
            }

            Collections.sort(intervals, (a, b) -> a[0] - b[0]);

            long yCovered = 0;
            int currentY = -1;
            for (int[] interval : intervals) {
                int startY = interval[0];
                int endY = interval[1];

                if (startY > currentY) {
                    yCovered += (long) (endY - startY);
                    currentY = endY;
                } else if (endY > currentY) {
                    yCovered += (long) (endY - currentY);
                    currentY = endY;
                }
            }

            totalArea = (totalArea + (long) (x2 - x1) * yCovered) % 1000000007;
        }

        return (int) totalArea;
    }
}