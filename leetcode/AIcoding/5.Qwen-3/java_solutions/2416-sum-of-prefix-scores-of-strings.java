public class Solution {

import java.util.*;

public class Solution {
    public int[] sumPrefixScores(List<String> words) {
        Map<String, Integer> prefixCount = new HashMap<>();
        for (String word : words) {
            for (int i = 1; i <= word.length(); i++) {
                String prefix = word.substring(0, i);
                prefixCount.put(prefix, prefixCount.getOrDefault(prefix, 0) + 1);
            }
        }

        int[] result = new int[words.size()];
        for (int i = 0; i < words.size(); i++) {
            String word = words.get(i);
            int score = 0;
            for (int j = 1; j <= word.length(); j++) {
                String prefix = word.substring(0, j);
                score += prefixCount.get(prefix);
            }
            result[i] = score;
        }

        return result;
    }
}
}