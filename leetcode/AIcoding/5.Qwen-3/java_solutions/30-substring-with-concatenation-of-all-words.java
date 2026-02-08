public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findSubstring(int s, String[] words) {
        List<Integer> result = new ArrayList<>();
        if (words == null || words.length == 0 || s == null || s.length() == 0) {
            return result;
        }
        int wordLen = words[0].length();
        int totalWords = words.length;
        int totalLen = wordLen * totalWords;
        int sLen = s.length();
        if (totalLen > sLen) {
            return result;
        }
        Map<String, Integer> wordCount = new HashMap<>();
        for (String word : words) {
            wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
        }
        for (int i = 0; i <= sLen - totalLen; i++) {
            Map<String, Integer> seen = new HashMap<>();
            boolean valid = true;
            for (int j = 0; j < totalWords; j++) {
                int start = i + j * wordLen;
                String word = s.substring(start, start + wordLen);
                if (!wordCount.containsKey(word)) {
                    valid = false;
                    break;
                }
                seen.put(word, seen.getOrDefault(word, 0) + 1);
                if (seen.get(word) > wordCount.get(word)) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                result.add(i);
            }
        }
        return result;
    }
}
}