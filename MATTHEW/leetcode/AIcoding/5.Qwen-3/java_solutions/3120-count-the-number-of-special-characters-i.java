public class Solution {

import java.util.*;

public class Solution {
    public int numberOfSpecialChars(String word) {
        Set<Character> set = new HashSet<>();
        for (char c : word.toCharArray()) {
            set.add(c);
        }
        int count = 0;
        for (char c : set) {
            if (word.indexOf(c) == word.lastIndexOf(c)) {
                continue;
            }
            boolean hasLower = false;
            boolean hasUpper = false;
            for (char d : word.toCharArray()) {
                if (d == Character.toLowerCase(c)) {
                    hasLower = true;
                } else if (d == Character.toUpperCase(c)) {
                    hasUpper = true;
                }
            }
            if (hasLower && hasUpper) {
                count++;
            }
        }
        return count;
    }
}
}