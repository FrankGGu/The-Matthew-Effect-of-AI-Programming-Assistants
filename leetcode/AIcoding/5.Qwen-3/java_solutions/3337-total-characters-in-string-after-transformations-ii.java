public class Solution {

import java.util.*;

public class Solution {
    public int numberOfSpecialChars(String word) {
        int result = 0;
        Set<Character> seen = new HashSet<>();
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            if (c >= 'a' && c <= 'z') {
                if (!seen.contains(c)) {
                    seen.add(c);
                    char upper = Character.toUpperCase(c);
                    if (word.indexOf(upper) != -1) {
                        result++;
                    }
                }
            }
        }
        return result;
    }
}
}