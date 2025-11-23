public class Solution {

import java.util.*;

public class Solution {
    public String shortestCompletingWord(String s, String[] words) {
        Map<Character, Integer> count = new HashMap<>();
        for (char c : s.toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }

        String result = null;
        for (String word : words) {
            boolean valid = true;
            Map<Character, Integer> temp = new HashMap<>(count);
            for (char c : word.toCharArray()) {
                if (temp.containsKey(c)) {
                    temp.put(c, temp.get(c) - 1);
                    if (temp.get(c) == 0) {
                        temp.remove(c);
                    }
                } else {
                    valid = false;
                    break;
                }
            }
            if (valid && (result == null || word.length() < result.length())) {
                result = word;
            }
        }
        return result;
    }
}
}