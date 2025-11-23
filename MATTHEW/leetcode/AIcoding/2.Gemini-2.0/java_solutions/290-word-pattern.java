import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean wordPattern(String pattern, String s) {
        String[] words = s.split(" ");
        if (pattern.length() != words.length) {
            return false;
        }

        Map<Character, String> patternToWord = new HashMap<>();
        Map<String, Character> wordToPattern = new HashMap<>();

        for (int i = 0; i < pattern.length(); i++) {
            char c = pattern.charAt(i);
            String word = words[i];

            if (!patternToWord.containsKey(c)) {
                if (wordToPattern.containsKey(word)) {
                    return false;
                }
                patternToWord.put(c, word);
                wordToPattern.put(word, c);
            } else {
                if (!patternToWord.get(c).equals(word)) {
                    return false;
                }
            }
        }

        return true;
    }
}