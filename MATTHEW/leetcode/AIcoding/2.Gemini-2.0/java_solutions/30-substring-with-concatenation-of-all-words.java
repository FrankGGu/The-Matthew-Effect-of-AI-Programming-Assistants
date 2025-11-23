import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<Integer> findSubstring(String s, String[] words) {
        List<Integer> result = new ArrayList<>();
        if (s == null || s.length() == 0 || words == null || words.length == 0) {
            return result;
        }

        int wordLength = words[0].length();
        int wordCount = words.length;
        int totalLength = wordLength * wordCount;

        if (s.length() < totalLength) {
            return result;
        }

        Map<String, Integer> wordFrequencyMap = new HashMap<>();
        for (String word : words) {
            wordFrequencyMap.put(word, wordFrequencyMap.getOrDefault(word, 0) + 1);
        }

        for (int i = 0; i <= s.length() - totalLength; i++) {
            Map<String, Integer> seenWords = new HashMap<>();
            boolean match = true;
            for (int j = 0; j < wordCount; j++) {
                int wordIndex = i + j * wordLength;
                String word = s.substring(wordIndex, wordIndex + wordLength);

                if (!wordFrequencyMap.containsKey(word)) {
                    match = false;
                    break;
                }

                seenWords.put(word, seenWords.getOrDefault(word, 0) + 1);

                if (seenWords.get(word) > wordFrequencyMap.get(word)) {
                    match = false;
                    break;
                }
            }

            if (match) {
                result.add(i);
            }
        }

        return result;
    }
}