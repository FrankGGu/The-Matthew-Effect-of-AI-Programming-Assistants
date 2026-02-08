public class Solution {

import java.util.*;

public class Solution {
    public int countLatticePoints(int[][] circles) {
        Set<String> points = new HashSet<>();
        for (int[] circle : circles) {
            int x = circle[0];
            int y = circle[1];
            int r = circle[2];
            for (int dx = -r; dx <= r; dx++) {
                for (int dy = -r; dy <= r; dy++) {
                    if (dx * dx + dy * dy <= r * r) {
                        points.add((x + dx) + "," + (y + dy));
                    }
                }
            }
        }
        return points.size();
    }
}
}