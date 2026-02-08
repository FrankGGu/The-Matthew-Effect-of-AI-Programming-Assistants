import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countWords(String[] words1, String[] words2) {
        Map<String, Integer> freq1 = new HashMap<>();
        Map<String, Integer> freq2 = new HashMap<>();

        for (String word : words1) {
            freq1.put(word, freq1.getOrDefault(word, 0) + 1);
        }

        for (String word : words2) {
            freq2.put(word, freq2.getOrDefault(word, 0) + 1);
        }

        int commonWordsCount = 0;
        for (String word : freq1.keySet()) {
            if (freq1.get(word) == 1 && freq2.getOrDefault(word, 0) == 1) {
                commonWordsCount++;
            }
        }

        return commonWordsCount;
    }
}