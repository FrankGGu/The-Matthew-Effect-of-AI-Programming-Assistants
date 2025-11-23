import java.util.*;

public class Solution {
    public List<Integer> countMentions(List<String> messages, List<String> users) {
        Map<String, Integer> mentionCount = new HashMap<>();
        for (String user : users) {
            mentionCount.put(user, 0);
        }

        for (String message : messages) {
            for (String user : users) {
                if (message.contains("@" + user)) {
                    mentionCount.put(user, mentionCount.get(user) + 1);
                }
            }
        }

        List<Integer> result = new ArrayList<>();
        for (String user : users) {
            result.add(mentionCount.get(user));
        }

        return result;
    }
}