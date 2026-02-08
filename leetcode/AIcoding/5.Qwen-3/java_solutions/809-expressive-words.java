public class Solution {

import java.util.*;

class Solution {
    public List<String> expressiveWords(String[] words, String s) {
        List<String> result = new ArrayList<>();
        for (String word : words) {
            if (isExpressive(word, s)) {
                result.add(word);
            }
        }
        return result;
    }

    private boolean isExpressive(String word, String s) {
        int i = 0, j = 0;
        while (i < word.length() && j < s.length()) {
            char c1 = word.charAt(i);
            char c2 = s.charAt(j);
            if (c1 != c2) return false;

            int count1 = 0, count2 = 0;
            while (i < word.length() && word.charAt(i) == c1) {
                i++;
                count1++;
            }
            while (j < s.length() && s.charAt(j) == c2) {
                j++;
                count2++;
            }

            if (count1 > count2 || (count1 < count2 && count2 < 3)) return false;
        }

        return i == word.length() && j == s.length();
    }
}
}