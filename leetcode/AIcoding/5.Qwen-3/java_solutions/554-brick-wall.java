public class Solution {

import java.util.*;

public class Solution {
    public int leastBricks(int[][] wall) {
        Map<Integer, Integer> map = new HashMap<>();
        int max = 0;
        for (int[] row : wall) {
            int pos = 0;
            for (int i = 0; i < row.length - 1; i++) {
                pos += row[i];
                map.put(pos, map.getOrDefault(pos, 0) + 1);
                max = Math.max(max, map.get(pos));
            }
        }
        return wall.length - max;
    }
}
}