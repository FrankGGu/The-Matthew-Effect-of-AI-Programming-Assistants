import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class Solution {
    public Map<String, Integer> countMentions(List<String> tweets, List<String> users) {
        Map<String, Integer> mentionCounts = new HashMap<>();
        Set<String> validUsers = new HashSet<>(users);

        Pattern mentionPattern = Pattern.compile("@([a-zA-Z0-9_]+)");

        for (String tweet : tweets) {
            Matcher matcher = mentionPattern.matcher(tweet);
            while (matcher.find()) {
                String mentionedUser = matcher.group(1);
                if (validUsers.contains(mentionedUser)) {
                    mentionCounts.put(mentionedUser, mentionCounts.getOrDefault(mentionedUser, 0) + 1);
                }
            }
        }

        return mentionCounts;
    }
}