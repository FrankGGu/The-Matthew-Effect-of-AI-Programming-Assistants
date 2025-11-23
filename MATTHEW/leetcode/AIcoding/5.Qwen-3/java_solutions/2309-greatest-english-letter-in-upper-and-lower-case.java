public class Solution {

import java.util.*;

public class Solution {
    public String greatestLetter(String s) {
        Set<Character> set = new HashSet<>();
        for (char c : s.toCharArray()) {
            set.add(c);
        }
        for (int i = 25; i >= 0; i--) {
            char upper = (char) ('A' + i);
            char lower = (char) ('a' + i);
            if (set.contains(upper) && set.contains(lower)) {
                return String.valueOf(upper);
            }
        }
        return "";
    }
}
}