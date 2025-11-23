public class Solution {

import java.util.*;

public class Solution {
    public List<String> wordSubsets(String[] words1, String[] words2) {
        Map<Character, Integer> maxFreq = new HashMap<>();
        for (String word : words2) {
            Map<Character, Integer> freq = getFrequencyMap(word);
            for (Map.Entry<Character, Integer> entry : freq.entrySet()) {
                char c = entry.getKey();
                int count = entry.getValue();
                maxFreq.put(c, Math.max(maxFreq.getOrDefault(c, 0), count));
            }
        }

        List<String> result = new ArrayList<>();
        for (String word : words1) {
            Map<Character, Integer> wordFreq = getFrequencyMap(word);
            boolean isSubset = true;
            for (Map.Entry<Character, Integer> entry : maxFreq.entrySet()) {
                char c = entry.getKey();
                int required = entry.getValue();
                if (wordFreq.getOrDefault(c, 0) < required) {
                    isSubset = false;
                    break;
                }
            }
            if (isSubset) {
                result.add(word);
            }
        }
        return result;
    }

    private Map<Character, Integer> getFrequencyMap(String s) {
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : s.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }
        return freq;
    }
}
}