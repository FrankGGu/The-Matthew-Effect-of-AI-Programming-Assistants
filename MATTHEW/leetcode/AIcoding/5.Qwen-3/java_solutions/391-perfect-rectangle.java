public class Solution {

import java.util.*;

public class Solution {
    public boolean isPerfectRectangle(int[][] rectangles) {
        Set<String> set = new HashSet<>();
        int area = 0;
        int minx = Integer.MAX_VALUE, miny = Integer.MAX_VALUE, maxx = Integer.MIN_VALUE, maxy = Integer.MIN_VALUE;

        for (int[] rect : rectangles) {
            int x1 = rect[0], y1 = rect[1], x2 = rect[2], y2 = rect[3];
            area += (x2 - x1) * (y2 - y1);

            minx = Math.min(minx, x1);
            miny = Math.min(miny, y1);
            maxx = Math.max(maxx, x2);
            maxy = Math.max(maxy, y2);

            String p1 = x1 + "," + y1;
            String p2 = x1 + "," + y2;
            String p3 = x2 + "," + y1;
            String p4 = x2 + "," + y2;

            for (String p : new String[]{p1, p2, p3, p4}) {
                if (set.contains(p)) {
                    set.remove(p);
                } else {
                    set.add(p);
                }
            }
        }

        int expectedArea = (maxx - minx) * (maxy - miny);
        if (area != expectedArea) return false;

        return set.size() == 4 && 
               set.contains(minx + "," + miny) && 
               set.contains(minx + "," + maxy) && 
               set.contains(maxx + "," + miny) && 
               set.contains(maxx + "," + maxy);
    }
}
}