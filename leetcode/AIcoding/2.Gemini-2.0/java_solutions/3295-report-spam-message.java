import java.util.*;

class Solution {
    public List<String> reportSpamMessages(String[] messages, String[] senders) {
        Map<String, Integer> senderCounts = new HashMap<>();
        for (int i = 0; i < messages.length; i++) {
            String sender = senders[i];
            senderCounts.put(sender, senderCounts.getOrDefault(sender, 0) + 1);
        }

        int maxCount = 0;
        for (int count : senderCounts.values()) {
            maxCount = Math.max(maxCount, count);
        }

        List<String> spamSenders = new ArrayList<>();
        for (Map.Entry<String, Integer> entry : senderCounts.entrySet()) {
            if (entry.getValue() == maxCount) {
                spamSenders.add(entry.getKey());
            }
        }

        return spamSenders;
    }
}