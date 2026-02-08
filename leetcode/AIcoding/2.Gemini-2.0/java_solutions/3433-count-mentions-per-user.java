import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<String> countMentionsPerUser(List<List<String>> userMentions) {
        Map<String, Integer> counts = new HashMap<>();
        for (List<String> mention : userMentions) {
            String user = mention.get(0);
            String mentioned = mention.get(1);
            counts.put(user, counts.getOrDefault(user, 0) + 1);
        }

        List<String> result = new java.util.ArrayList<>();
        for (Map.Entry<String, Integer> entry : counts.entrySet()) {
            result.add(entry.getKey() + "," + entry.getValue());
        }

        return result;
    }
}