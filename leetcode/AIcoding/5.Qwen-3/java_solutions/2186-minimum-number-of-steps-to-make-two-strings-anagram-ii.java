public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int minSteps(String s, String t) {
        Map<Character, Integer> count = new HashMap<>();

        for (char c : s.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }

        for (char c : t.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) - 1);
        }

        int steps = 0;
        for (int v : count.values()) {
            steps += Math.abs(v);
        }

        return steps / 2;
    }
}
}