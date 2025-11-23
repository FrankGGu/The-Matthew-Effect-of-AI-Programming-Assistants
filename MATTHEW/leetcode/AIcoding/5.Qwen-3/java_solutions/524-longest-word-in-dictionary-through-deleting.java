public class Solution {

import java.util.*;

public class Solution {
    public String findLongestWord(String s, List<String> d) {
        Collections.sort(d, (a, b) -> {
            if (b.length() != a.length()) {
                return b.length() - a.length();
            } else {
                return a.compareTo(b);
            }
        });
        for (String word : d) {
            if (isSubsequence(word, s)) {
                return word;
            }
        }
        return "";
    }

    private boolean isSubsequence(String word, String s) {
        int i = 0, j = 0;
        while (i < word.length() && j < s.length()) {
            if (word.charAt(i) == s.charAt(j)) {
                i++;
            }
            j++;
        }
        return i == word.length();
    }
}
}