public class Solution {

import java.util.*;

public class Solution {
    public String customSortString(String S, String T) {
        Map<Character, Integer> count = new HashMap<>();
        for (char c : T.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }

        StringBuilder result = new StringBuilder();

        for (char c : S.toCharArray()) {
            if (count.containsKey(c)) {
                for (int i = 0; i < count.get(c); i++) {
                    result.append(c);
                }
                count.remove(c);
            }
        }

        for (Map.Entry<Character, Integer> entry : count.entrySet()) {
            for (int i = 0; i < entry.getValue(); i++) {
                result.append(entry.getKey());
            }
        }

        return result.toString();
    }
}
}