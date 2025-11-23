import java.util.*;

public class Solution {
    public List<Integer> findSubstring(String s, String[] words) {
        List<Integer> result = new ArrayList<>();
        if (s == null || words == null || words.length == 0) return result;

        int wordLength = words[0].length();
        int totalWordsLength = wordLength * words.length;
        Map<String, Integer> wordCount = new HashMap<>();

        for (String word : words) {
            wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
        }

        for (int i = 0; i <= s.length() - totalWordsLength; i++) {
            Map<String, Integer> seenWords = new HashMap<>();
            int j = 0;

            while (j < words.length) {
                String word = s.substring(i + j * wordLength, i + (j + 1) * wordLength);
                if (wordCount.containsKey(word)) {
                    seenWords.put(word, seenWords.getOrDefault(word, 0) + 1);
                    if (seenWords.get(word) > wordCount.get(word)) break;
                } else {
                    break;
                }
                j++;
            }

            if (j == words.length) {
                result.add(i);
            }
        }

        return result;
    }
}