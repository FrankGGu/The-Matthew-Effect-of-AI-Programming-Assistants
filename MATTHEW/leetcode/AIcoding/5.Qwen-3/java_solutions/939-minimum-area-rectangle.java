public class Solution {

import java.util.*;

public class Solution {
    public int minAreaRect(int[][] rect) {
        Set<String> points = new HashSet<>();
        for (int[] r : rect) {
            points.add(r[0] + "," + r[1]);
        }

        int minArea = Integer.MAX_VALUE;
        for (int i = 0; i < rect.length; i++) {
            for (int j = i + 1; j < rect.length; j++) {
                int x1 = rect[i][0];
                int y1 = rect[i][1];
                int x2 = rect[j][0];
                int y2 = rect[j][1];

                if (x1 != x2 && y1 != y2) {
                    String p1 = x1 + "," + y2;
                    String p2 = x2 + "," + y1;
                    if (points.contains(p1) && points.contains(p2)) {
                        int area = Math.abs(x1 - x2) * Math.abs(y1 - y2);
                        minArea = Math.min(minArea, area);
                    }
                }
            }
        }

        return minArea == Integer.MAX_VALUE ? 0 : minArea;
    }
}
}