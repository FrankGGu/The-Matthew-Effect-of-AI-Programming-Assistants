public class Solution {

import java.util.*;

public class Solution {
    public int numberOfSpecialChars(String word) {
        int result = 0;
        Set<Character> lowerSet = new HashSet<>();
        Set<Character> upperSet = new HashSet<>();

        for (char c : word.toCharArray()) {
            if (c >= 'a' && c <= 'z') {
                lowerSet.add(c);
            } else if (c >= 'A' && c <= 'Z') {
                upperSet.add(c);
            }
        }

        for (char c : lowerSet) {
            char upperC = (char) ('A' + c - 'a');
            if (upperSet.contains(upperC)) {
                result++;
            }
        }

        return result;
    }
}
}