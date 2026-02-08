public class Solution {

import java.util.*;

public class Solution {
    public int rectangleArea(int[][] rectangles) {
        int MOD = 1000000007;
        List<int[]> events = new ArrayList<>();
        for (int[] rect : rectangles) {
            events.add(new int[]{rect[0], 0, rect[1], rect[3]});
            events.add(new int[]{rect[2], 1, rect[1], rect[3]});
        }
        Collections.sort(events, (a, b) -> {
            if (a[0] != b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });
        long area = 0;
        int prevX = 0;
        List<int[]> active = new ArrayList<>();
        for (int[] event : events) {
            int x = event[0];
            int type = event[1];
            int y1 = event[2];
            int y2 = event[3];
            if (prevX < x && !active.isEmpty()) {
                long height = 0;
                for (int[] seg : active) {
                    height += seg[1] - seg[0];
                }
                area += (long)(x - prevX) * height;
                area %= MOD;
            }
            if (type == 0) {
                active.add(new int[]{y1, y2});
                Collections.sort(active, (a, b) -> a[0] - b[0]);
            } else {
                for (int i = 0; i < active.size(); i++) {
                    if (active.get(i)[0] == y1 && active.get(i)[1] == y2) {
                        active.remove(i);
                        break;
                    }
                }
            }
            prevX = x;
        }
        return (int) (area % MOD);
    }
}
}