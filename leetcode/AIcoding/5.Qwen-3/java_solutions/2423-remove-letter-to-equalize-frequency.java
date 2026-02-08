public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean equalizeFrequency(String s) {
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : s.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        for (char c : s.toCharArray()) {
            freq.put(c, freq.get(c) - 1);
            if (freq.get(c) == 0) {
                freq.remove(c);
            }

            boolean allEqual = true;
            int first = -1;
            for (int count : freq.values()) {
                if (first == -1) {
                    first = count;
                } else if (count != first) {
                    allEqual = false;
                    break;
                }
            }

            if (allEqual) {
                return true;
            }

            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        return false;
    }
}
}