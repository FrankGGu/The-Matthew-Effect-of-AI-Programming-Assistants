import java.util.*;

class Solution {
    public List<List<String>> countMentionsPerUser(String[] usernames, String[] tweets) {
        Map<String, Integer> mentionCount = new HashMap<>();
        for (String tweet : tweets) {
            String[] words = tweet.split(" ");
            for (String word : words) {
                if (word.startsWith("@")) {
                    String username = word.substring(1);
                    mentionCount.put(username, mentionCount.getOrDefault(username, 0) + 1);
                }
            }
        }

        List<List<String>> result = new ArrayList<>();
        for (String username : usernames) {
            int count = mentionCount.getOrDefault(username, 0);
            result.add(Arrays.asList(username, String.valueOf(count)));
        }

        return result;
    }
}