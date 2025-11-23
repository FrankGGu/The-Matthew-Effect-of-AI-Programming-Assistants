public class Solution {

import java.util.*;

public class Solution {
    public String[] extractWords(String[] words, String pattern) {
        List<String> result = new ArrayList<>();
        for (String word : words) {
            if (match(word, pattern)) {
                result.add(word);
            }
        }
        return result.toArray(new String[0]);
    }

    private boolean match(String word, String pattern) {
        if (word.length() != pattern.length()) {
            return false;
        }
        Map<Character, Character> map1 = new HashMap<>();
        Map<Character, Character> map2 = new HashMap<>();
        for (int i = 0; i < word.length(); i++) {
            char w = word.charAt(i);
            char p = pattern.charAt(i);
            if (map1.containsKey(w)) {
                if (map1.get(w) != p) {
                    return false;
                }
            } else if (map2.containsKey(p)) {
                if (map2.get(p) != w) {
                    return false;
                }
            } else {
                map1.put(w, p);
                map2.put(p, w);
            }
        }
        return true;
    }
}
}