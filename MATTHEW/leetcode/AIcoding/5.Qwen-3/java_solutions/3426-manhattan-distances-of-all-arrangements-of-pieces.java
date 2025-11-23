public class Solution {

import java.util.*;

public class Solution {
    public int[][] allCellsDistOrder(int R, int C, int r0, int c0) {
        List<int[]> result = new ArrayList<>();
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                result.add(new int[]{i, j});
            }
        }
        result.sort((a, b) -> {
            int distA = Math.abs(a[0] - r0) + Math.abs(a[1] - c0);
            int distB = Math.abs(b[0] - r0) + Math.abs(b[1] - c0);
            return Integer.compare(distA, distB);
        });
        return result.toArray(new int[0][0]);
    }
}
}