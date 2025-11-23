public class Solution {

import java.util.*;

public class Solution {
    public int minSeconds(int[] s) {
        Map<Character, List<Integer>> positions = new HashMap<>();
        for (int i = 0; i < s.length; i++) {
            char c = (char) ('a' + s[i]);
            positions.putIfAbsent(c, new ArrayList<>());
            positions.get(c).add(i);
        }

        int maxDist = 0;
        for (Map.Entry<Character, List<Integer>> entry : positions.entrySet()) {
            List<Integer> list = entry.getValue();
            int n = list.size();
            int max = 0;
            for (int i = 0; i < n; i++) {
                int prev = list.get(i);
                int next = list.get((i + 1) % n);
                int dist = Math.min(next - prev, prev + s.length - next);
                max = Math.max(max, dist);
            }
            maxDist = Math.max(maxDist, max);
        }

        return maxDist;
    }
}
}