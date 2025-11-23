public class Solution {

import java.util.*;

public class Solution {
    public String[] uncommonFromSentences(String[] sentences) {
        Map<String, Integer> frequency = new HashMap<>();
        for (String sentence : sentences) {
            String[] words = sentence.split(" ");
            for (String word : words) {
                frequency.put(word, frequency.getOrDefault(word, 0) + 1);
            }
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : frequency.entrySet()) {
            if (entry.getValue() == 1) {
                result.add(entry.getKey());
            }
        }

        return result.toArray(new String[0]);
    }
}
}