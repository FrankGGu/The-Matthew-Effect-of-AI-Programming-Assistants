public class Solution {

import java.util.*;

public class Solution {
    public int minAreaRect(HashSet<int[]> points) {
        Map<Integer, Set<Integer>> xToY = new HashMap<>();
        for (int[] p : points) {
            xToY.putIfAbsent(p[0], new HashSet<>());
            xToY.get(p[0]).add(p[1]);
        }

        int minArea = Integer.MAX_VALUE;
        for (int x1 : xToY.keySet()) {
            Set<Integer> y1s = xToY.get(x1);
            for (int x2 : xToY.keySet()) {
                if (x1 == x2) continue;
                Set<Integer> y2s = xToY.get(x2);
                List<Integer> commonY = new ArrayList<>();
                for (int y : y1s) {
                    if (y2s.contains(y)) {
                        commonY.add(y);
                    }
                }
                if (commonY.size() >= 2) {
                    Collections.sort(commonY);
                    for (int i = 1; i < commonY.size(); i++) {
                        int height = commonY.get(i) - commonY.get(i - 1);
                        int width = Math.abs(x2 - x1);
                        minArea = Math.min(minArea, width * height);
                    }
                }
            }
        }
        return minArea == Integer.MAX_VALUE ? 0 : minArea;
    }
}
}