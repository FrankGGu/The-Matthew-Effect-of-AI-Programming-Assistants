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
            if (word.indexOf(c) != word.lastIndexOf(c)) {
                count++;
            }
        }
        return count;
    }
}
}