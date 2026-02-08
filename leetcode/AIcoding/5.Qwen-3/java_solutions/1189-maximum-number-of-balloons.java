public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int maxNumberOfBalloons(String text) {
        Map<Character, Integer> count = new HashMap<>();
        for (char c : text.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }

        int max = Integer.MAX_VALUE;
        for (char c : "balloon".toCharArray()) {
            if (count.containsKey(c)) {
                if (c == 'l' || c == 'o') {
                    max = Math.min(max, count.get(c) / 2);
                } else {
                    max = Math.min(max, count.get(c));
                }
            } else {
                return 0;
            }
        }

        return max;
    }
}
}