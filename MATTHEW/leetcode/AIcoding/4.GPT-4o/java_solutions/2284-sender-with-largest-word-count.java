import java.util.HashMap;
import java.util.Map;

public class Solution {
    public String largestWordCount(String[] messages, String[] senders) {
        Map<String, Integer> wordCount = new HashMap<>();
        for (int i = 0; i < messages.length; i++) {
            int count = messages[i].split(" ").length;
            wordCount.put(senders[i], wordCount.getOrDefault(senders[i], 0) + count);
        }
        String result = "";
        int maxCount = 0;
        for (Map.Entry<String, Integer> entry : wordCount.entrySet()) {
            String sender = entry.getKey();
            int count = entry.getValue();
            if (count > maxCount || (count == maxCount && sender.compareTo(result) > 0)) {
                result = sender;
                maxCount = count;
            }
        }
        return result;
    }
}