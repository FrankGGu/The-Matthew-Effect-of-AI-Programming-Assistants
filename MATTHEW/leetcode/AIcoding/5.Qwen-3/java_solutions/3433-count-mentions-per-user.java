public class Solution {

import java.util.*;

public class Solution {
    public List<String> countMentionsPerUser(List<String> posts) {
        Map<String, Integer> userMentionCount = new HashMap<>();

        for (String post : posts) {
            String[] words = post.split("\\s+");
            for (String word : words) {
                if (word.startsWith("@")) {
                    String username = word.substring(1);
                    userMentionCount.put(username, userMentionCount.getOrDefault(username, 0) + 1);
                }
            }
        }

        List<Map.Entry<String, Integer>> sortedEntries = new ArrayList<>(userMentionCount.entrySet());
        sortedEntries.sort((a, b) -> {
            int cmp = Integer.compare(b.getValue(), a.getValue());
            if (cmp != 0) return cmp;
            return a.getKey().compareTo(b.getKey());
        });

        List<String> result = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : sortedEntries) {
            result.add(entry.getKey() + " " + entry.getValue());
        }

        return result;
    }
}
}