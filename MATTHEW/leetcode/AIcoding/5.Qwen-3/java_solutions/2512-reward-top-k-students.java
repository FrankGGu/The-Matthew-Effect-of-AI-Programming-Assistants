public class Solution {

import java.util.*;

public class Solution {
    public String[] topStudents(String[] words, int[] scores, String[] banned, int k) {
        Set<String> bannedSet = new HashSet<>(Arrays.asList(banned));
        Map<String, Integer> wordScoreMap = new HashMap<>();

        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            if (!bannedSet.contains(word)) {
                wordScoreMap.put(word, wordScoreMap.getOrDefault(word, 0) + scores[i]);
            }
        }

        List<Map.Entry<String, Integer>> list = new ArrayList<>(wordScoreMap.entrySet());
        list.sort((a, b) -> {
            if (!a.getValue().equals(b.getValue())) {
                return b.getValue() - a.getValue();
            } else {
                return a.getKey().compareTo(b.getKey());
            }
        });

        String[] result = new String[k];
        for (int i = 0; i < k; i++) {
            result[i] = list.get(i).getKey();
        }

        return result;
    }
}
}