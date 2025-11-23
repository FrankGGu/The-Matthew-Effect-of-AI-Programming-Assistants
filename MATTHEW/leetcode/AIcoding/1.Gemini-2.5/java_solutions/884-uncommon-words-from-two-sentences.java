import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public String[] uncommonFromSentences(String s1, String s2) {
        Map<String, Integer> wordCounts = new HashMap<>();

        for (String word : s1.split(" ")) {
            wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
        }

        for (String word : s2.split(" ")) {
            wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
        }

        List<String> uncommonWords = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : wordCounts.entrySet()) {
            if (entry.getValue() == 1) {
                uncommonWords.add(entry.getKey());
            }
        }

        return uncommonWords.toArray(new String[0]);
    }
}