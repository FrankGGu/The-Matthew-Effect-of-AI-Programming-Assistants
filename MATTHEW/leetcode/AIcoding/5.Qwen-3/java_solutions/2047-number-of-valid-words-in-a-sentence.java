public class Solution {

import java.util.*;

public class Solution {
    public int countValidWords(String sentence) {
        int count = 0;
        String[] words = sentence.split(" ");
        for (String word : words) {
            if (isValid(word)) {
                count++;
            }
        }
        return count;
    }

    private boolean isValid(String word) {
        boolean hasHyphen = false;
        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            if (Character.isDigit(c)) {
                return false;
            }
            if (c == '-') {
                if (hasHyphen || i == 0 || i == word.length() - 1 || !Character.isLetter(word.charAt(i - 1)) || !Character.isLetter(word.charAt(i + 1))) {
                    return false;
                }
                hasHyphen = true;
            }
            if (c == '!' || c == '.' || c == ',') {
                if (i != word.length() - 1) {
                    return false;
                }
            }
        }
        return true;
    }
}
}