public class Solution {

import java.util.*;

public class Solution {
    public List<String> printWordsVertically(String s) {
        String[] words = s.split(" ");
        int maxLen = 0;
        for (String word : words) {
            maxLen = Math.max(maxLen, word.length());
        }
        List<String> result = new ArrayList<>();
        for (int i = 0; i < maxLen; i++) {
            StringBuilder verticalWord = new StringBuilder();
            for (int j = 0; j < words.length; j++) {
                if (i < words[j].length()) {
                    verticalWord.append(words[j].charAt(i));
                } else {
                    verticalWord.append(' ');
                }
            }
            // Remove trailing spaces
            while (verticalWord.length() > 0 && verticalWord.charAt(verticalWord.length() - 1) == ' ') {
                verticalWord.deleteCharAt(verticalWord.length() - 1);
            }
            result.add(verticalWord.toString());
        }
        return result;
    }
}
}