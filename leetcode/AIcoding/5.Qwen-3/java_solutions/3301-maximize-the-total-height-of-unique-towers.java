public class Solution {

import java.util.*;

public class Solution {
    public int maximumHeight(int[][] n) {
        Map<Integer, Integer> map = new HashMap<>();
        for (int[] tower : n) {
            int height = tower[0];
            int count = tower[1];
            map.put(height, map.getOrDefault(height, 0) + count);
        }
        List<Integer> heights = new ArrayList<>(map.keySet());
        Collections.sort(heights);
        int total = 0;
        int prev = 0;
        for (int h : heights) {
            if (h > prev) {
                total += map.get(h);
                prev = h;
            }
        }
        return total;
    }
}
}