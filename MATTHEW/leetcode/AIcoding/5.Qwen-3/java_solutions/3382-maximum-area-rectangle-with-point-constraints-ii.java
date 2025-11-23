public class Solution {

import java.util.*;

public class Solution {
    public int maxArea(int[][] points, int[] queries) {
        List<Integer> result = new ArrayList<>();
        for (int[] q : queries) {
            int x = q[0];
            int y = q[1];
            int w = q[2];
            int h = q[3];
            int maxArea = 0;
            Set<String> set = new HashSet<>();
            for (int[] p : points) {
                int px = p[0];
                int py = p[1];
                if (px >= x && px <= x + w && py >= y && py <= y + h) {
                    set.add(px + "," + py);
                }
            }
            if (set.size() < 2) {
                result.add(0);
                continue;
            }
            List<int[]> list = new ArrayList<>();
            for (String s : set) {
                String[] parts = s.split(",");
                list.add(new int[]{Integer.parseInt(parts[0]), Integer.parseInt(parts[1])});
            }
            Collections.sort(list, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
            int n = list.size();
            int max = 0;
            for (int i = 0; i < n; i++) {
                for (int j = i + 1; j < n; j++) {
                    int dx = list[j][0] - list[i][0];
                    int dy = list[j][1] - list[i][1];
                    if (dx * dy > max) {
                        max = dx * dy;
                    }
                }
            }
            result.add(max);
        }
        int[] res = new int[result.size()];
        for (int i = 0; i < res.length; i++) {
            res[i] = result.get(i);
        }
        return res[0];
    }
}
}