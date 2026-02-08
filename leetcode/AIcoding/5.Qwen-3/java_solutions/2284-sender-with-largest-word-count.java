public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public String largestWordCount(String[] messages) {
        Map<String, Integer> senderCounts = new HashMap<>();
        String maxSender = "";
        int maxCount = 0;

        for (int i = 0; i < messages.length; i++) {
            String[] parts = messages[i].split(" ", 2);
            String sender = parts[0];
            String message = parts.length > 1 ? parts[1] : "";

            int wordCount = message.split(" ").length;
            senderCounts.put(sender, senderCounts.getOrDefault(sender, 0) + wordCount);

            if (senderCounts.get(sender) > maxCount || 
                (senderCounts.get(sender) == maxCount && sender.compareTo(maxSender) < 0)) {
                maxCount = senderCounts.get(sender);
                maxSender = sender;
            }
        }

        return maxSender;
    }
}
}