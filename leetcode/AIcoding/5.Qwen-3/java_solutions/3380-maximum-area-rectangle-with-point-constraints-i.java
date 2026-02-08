public class Solution {

import java.util.*;

public class Solution {
    public int maxAreaRectangle(int[][] points) {
        Map<Integer, Set<Integer>> xToY = new HashMap<>();
        for (int[] point : points) {
            xToY.putIfAbsent(point[0], new HashSet<>());
            xToY.get(point[0]).add(point[1]);
        }

        List<Integer> xs = new ArrayList<>(xToY.keySet());
        Collections.sort(xs);

        int maxArea = 0;

        for (int i = 0; i < xs.size(); i++) {
            for (int j = i + 1; j < xs.size(); j++) {
                int x1 = xs.get(i);
                int x2 = xs.get(j);
                Set<Integer> ySet1 = xToY.get(x1);
                Set<Integer> ySet2 = xToY.get(x2);
                Set<Integer> commonY = new HashSet<>(ySet1);
                commonY.retainAll(ySet2);
                if (!commonY.isEmpty()) {
                    int height = Collections.max(commonY) - Collections.min(commonY);
                    int width = x2 - x1;
                    maxArea = Math.max(maxArea, width * height);
                }
            }
        }

        return maxArea;
    }
}
}