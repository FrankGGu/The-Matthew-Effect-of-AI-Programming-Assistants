public class Solution {

import java.util.*;

public class Solution {
    public String[] uncommonFromSentences(String A, String B) {
        Map<String, Integer> count = new HashMap<>();
        String[] wordsA = A.split(" ");
        String[] wordsB = B.split(" ");

        for (String word : wordsA) {
            count.put(word, count.getOrDefault(word, 0) + 1);
        }

        for (String word : wordsB) {
            count.put(word, count.getOrDefault(word, 0) + 1);
        }

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : count.entrySet()) {
            if (entry.getValue() == 1) {
                result.add(entry.getKey());
            }
        }

        return result.toArray(new String[0]);
    }
}
}