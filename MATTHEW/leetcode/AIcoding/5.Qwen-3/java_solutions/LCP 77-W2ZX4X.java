public class Solution {

import java.util.*;

public class Solution {
    public int[] topStudents(String[] words, String[] badges, int[] hitPoints, String[] topWords, int topWordsCount) {
        Map<String, Integer> badgeMap = new HashMap<>();
        for (int i = 0; i < badges.length; i++) {
            badgeMap.put(badges[i], hitPoints[i]);
        }

        Map<String, Integer> wordCount = new HashMap<>();
        for (String word : words) {
            wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
        }

        List<Map.Entry<String, Integer>> list = new ArrayList<>(wordCount.entrySet());
        list.sort((a, b) -> {
            int cmp = Integer.compare(b.getValue(), a.getValue());
            if (cmp != 0) return cmp;
            return a.getKey().compareTo(b.getKey());
        });

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : list) {
            String word = entry.getKey();
            int count = entry.getValue();
            if (badgeMap.containsKey(word)) {
                result.add(word);
                if (result.size() == topWordsCount) break;
            }
        }

        int[] res = new int[result.size()];
        for (int i = 0; i < res.length; i++) {
            res[i] = badgeMap.get(result.get(i));
        }

        return res;
    }
}
}