public class Solution {

import java.util.*;

class Solution {
    public boolean validSquare(int[] p1, int[] p2, int[] p3, int[] p4) {
        Set<Integer> set = new HashSet<>();
        int[][] points = {p1, p2, p3, p4};
        for (int i = 0; i < 4; i++) {
            for (int j = i + 1; j < 4; j++) {
                int dx = points[i][0] - points[j][0];
                int dy = points[i][1] - points[j][1];
                set.add(dx * dx + dy * dy);
            }
        }
        return set.size() == 2;
    }
}
}