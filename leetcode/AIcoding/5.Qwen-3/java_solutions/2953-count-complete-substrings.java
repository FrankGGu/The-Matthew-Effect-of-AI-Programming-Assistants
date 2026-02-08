public class Solution {

import java.util.*;

public class Solution {
    public int countCompleteSubstrings(String s) {
        int result = 0;
        List<String> words = new ArrayList<>();
        for (int i = 0; i < s.length(); i++) {
            if (i > 0 && Math.abs(s.charAt(i) - s.charAt(i - 1)) > 1) {
                words.add(s.substring(0, i));
                s = s.substring(i);
                i = -1;
            }
        }
        words.add(s);

        for (String word : words) {
            result += countSubstrings(word);
        }
        return result;
    }

    private int countSubstrings(String s) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            Set<Character> set = new HashSet<>();
            for (int j = i; j < s.length(); j++) {
                set.add(s.charAt(j));
                if (set.size() == 26) {
                    count++;
                }
            }
        }
        return count;
    }
}
}