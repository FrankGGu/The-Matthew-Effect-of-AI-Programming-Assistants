public class Solution {

import java.util.*;

public class Solution {
    public int maxLengthBetweenEqualCharacters(String s) {
        int maxLen = -1;
        Map<Character, Integer> firstOccurrence = new HashMap<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (!firstOccurrence.containsKey(c)) {
                firstOccurrence.put(c, i);
            } else {
                int len = i - firstOccurrence.get(c) - 1;
                if (len > maxLen) {
                    maxLen = len;
                }
            }
        }

        return maxLen;
    }
}
}