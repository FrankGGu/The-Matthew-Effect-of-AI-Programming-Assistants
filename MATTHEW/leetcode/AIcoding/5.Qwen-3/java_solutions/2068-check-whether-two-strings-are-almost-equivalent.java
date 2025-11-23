public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean checkAlmostEquivalent(String word1, String word2) {
        Map<Character, Integer> count1 = new HashMap<>();
        Map<Character, Integer> count2 = new HashMap<>();

        for (char c : word1.toCharArray()) {
            count1.put(c, count1.getOrDefault(c, 0) + 1);
        }

        for (char c : word2.toCharArray()) {
            count2.put(c, count2.getOrDefault(c, 0) + 1);
        }

        for (char c : count1.keySet()) {
            if (Math.abs(count1.get(c) - count2.getOrDefault(c, 0)) > 3) {
                return false;
            }
        }

        for (char c : count2.keySet()) {
            if (Math.abs(count2.get(c) - count1.getOrDefault(c, 0)) > 3) {
                return false;
            }
        }

        return true;
    }
}
}