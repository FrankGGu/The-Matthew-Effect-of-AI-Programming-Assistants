public class Solution {

import java.util.*;

public class Solution {
    public List<String> longestCommonSuffixQueries(String[] words, int[][] queries) {
        Map<String, Integer> suffixCount = new HashMap<>();
        for (String word : words) {
            for (int i = 0; i < word.length(); i++) {
                String suffix = word.substring(i);
                suffixCount.put(suffix, suffixCount.getOrDefault(suffix, 0) + 1);
            }
        }

        List<String> result = new ArrayList<>();
        for (int[] query : queries) {
            String word = words[query[0]];
            int k = query[1];
            Set<String> suffixes = new HashSet<>();
            for (int i = 0; i < word.length(); i++) {
                suffixes.add(word.substring(i));
            }

            List<Map.Entry<String, Integer>> list = new ArrayList<>(suffixCount.entrySet());
            list.sort((a, b) -> {
                if (!a.getKey().endsWith(b.getKey())) {
                    return -1;
                }
                return b.getValue() - a.getValue();
            });

            int count = 0;
            String longestSuffix = "";
            for (Map.Entry<String, Integer> entry : list) {
                if (suffixes.contains(entry.getKey())) {
                    longestSuffix = entry.getKey();
                    count++;
                    if (count == k) {
                        break;
                    }
                }
            }

            result.add(longestSuffix);
        }

        return result;
    }
}
}