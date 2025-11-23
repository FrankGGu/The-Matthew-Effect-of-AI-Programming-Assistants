public class Solution {

import java.util.*;

public class Solution {
    public int rearrangeCharacters(String s, String target) {
        Map<Character, Integer> countS = new HashMap<>();
        Map<Character, Integer> countTarget = new HashMap<>();

        for (char c : s.toCharArray()) {
            countS.put(c, countS.getOrDefault(c, 0) + 1);
        }

        for (char c : target.toCharArray()) {
            countTarget.put(c, countTarget.getOrDefault(c, 0) + 1);
        }

        int min = Integer.MAX_VALUE;

        for (char c : countTarget.keySet()) {
            if (!countS.containsKey(c)) {
                return 0;
            }
            min = Math.min(min, countS.get(c) / countTarget.get(c));
        }

        return min;
    }
}
}