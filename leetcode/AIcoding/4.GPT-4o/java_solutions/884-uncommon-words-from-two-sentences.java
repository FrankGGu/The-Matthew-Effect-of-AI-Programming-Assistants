import java.util.*;

public class Solution {
    public String[] uncommonFromSentences(String A, String B) {
        String[] wordsA = A.split(" ");
        String[] wordsB = B.split(" ");
        Map<String, Integer> wordCount = new HashMap<>();

        for (String word : wordsA) {
            wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
        }
        for (String word : wordsB) {
            wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : wordCount.entrySet()) {
            if (entry.getValue() == 1) {
                result.add(entry.getKey());
            }
        }

        return result.toArray(new String[0]);
    }
}