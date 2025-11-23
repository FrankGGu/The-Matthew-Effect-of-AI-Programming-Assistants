public class Solution {

import java.util.*;

public class Solution {
    public int numStrings(String[] patterns, String word) {
        Set<String> substrings = new HashSet<>();
        for (int i = 0; i < word.length(); i++) {
            for (int j = i + 1; j <= word.length(); j++) {
                substrings.add(word.substring(i, j));
            }
        }
        int count = 0;
        for (String pattern : patterns) {
            if (substrings.contains(pattern)) {
                count++;
            }
        }
        return count;
    }
}
}