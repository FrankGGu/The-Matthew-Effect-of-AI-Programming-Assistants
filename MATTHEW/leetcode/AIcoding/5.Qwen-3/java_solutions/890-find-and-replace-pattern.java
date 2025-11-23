public class Solution {

import java.util.*;

class Solution {
    public List<String> findAndReplacePattern(String[] words, String pattern) {
        List<String> result = new ArrayList<>();
        for (String word : words) {
            if (isMatch(word, pattern)) {
                result.add(word);
            }
        }
        return result;
    }

    private boolean isMatch(String word, String pattern) {
        if (word.length() != pattern.length()) {
            return false;
        }
        Map<Character, Character> wordToPattern = new HashMap<>();
        Map<Character, Character> patternToWord = new HashMap<>();
        for (int i = 0; i < word.length(); i++) {
            char w = word.charAt(i);
            char p = pattern.charAt(i);
            if (wordToPattern.containsKey(w)) {
                if (wordToPattern.get(w) != p) {
                    return false;
                }
            } else {
                if (patternToWord.containsKey(p)) {
                    if (patternToWord.get(p) != w) {
                        return false;
                    }
                } else {
                    wordToPattern.put(w, p);
                    patternToWord.put(p, w);
                }
            }
        }
        return true;
    }
}
}