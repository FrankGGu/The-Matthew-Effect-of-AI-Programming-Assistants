import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean isRectangleCover(int[][] rectangles) {
        int area = 0;
        Map<String, Integer> count = new HashMap<>();
        int x1 = Integer.MAX_VALUE, y1 = Integer.MAX_VALUE;
        int x2 = Integer.MIN_VALUE, y2 = Integer.MIN_VALUE;

        for (int[] rect : rectangles) {
            x1 = Math.min(x1, rect[0]);
            y1 = Math.min(y1, rect[1]);
            x2 = Math.max(x2, rect[2]);
            y2 = Math.max(y2, rect[3]);
            area += (rect[2] - rect[0]) * (rect[3] - rect[1]);

            String[] corners = {
                rect[0] + "," + rect[1],
                rect[0] + "," + rect[3],
                rect[2] + "," + rect[1],
                rect[2] + "," + rect[3]
            };

            for (String corner : corners) {
                count.put(corner, count.getOrDefault(corner, 0) + 1);
            }
        }

        if (area != (x2 - x1) * (y2 - y1)) {
            return false;
        }

        int cornerCount = 0;
        for (Map.Entry<String, Integer> entry : count.entrySet()) {
            if (entry.getValue() % 2 == 1) {
                cornerCount++;
            } else if (cornerCount > 4) {
                return false;
            }
        }

        return cornerCount == 4;
    }
}