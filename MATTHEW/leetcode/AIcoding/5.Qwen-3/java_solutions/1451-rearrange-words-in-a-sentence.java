public class Solution {

import java.util.*;

public class Solution {
    public String arrangeWords(String sentence) {
        String[] words = sentence.toLowerCase().split(" ");
        Map<String, Integer> freq = new HashMap<>();
        for (String word : words) {
            freq.put(word, freq.getOrDefault(word, 0) + 1);
        }
        List<Map.Entry<String, Integer>> list = new ArrayList<>(freq.entrySet());
        list.sort((a, b) -> a.getValue().compareTo(b.getValue()));
        StringBuilder result = new StringBuilder();
        for (Map.Entry<String, Integer> entry : list) {
            String word = entry.getKey();
            int count = entry.getValue();
            for (int i = 0; i < count; i++) {
                result.append(word).append(" ");
            }
        }
        return result.toString().trim();
    }
}
}