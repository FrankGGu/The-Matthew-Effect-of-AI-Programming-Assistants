import java.util.HashMap;
import java.util.Map;

class Solution {
    public String largestWordCount(String[] messages, String[] senders) {
        Map<String, Integer> wordCountMap = new HashMap<>();
        int n = messages.length;

        for (int i = 0; i < n; i++) {
            String message = messages[i];
            String sender = senders[i];

            int wordCount = message.split(" ").length;

            wordCountMap.put(sender, wordCountMap.getOrDefault(sender, 0) + wordCount);
        }

        String largestSender = "";
        int maxWordCount = 0;

        for (Map.Entry<String, Integer> entry : wordCountMap.entrySet()) {
            String sender = entry.getKey();
            int wordCount = entry.getValue();

            if (wordCount > maxWordCount) {
                maxWordCount = wordCount;
                largestSender = sender;
            } else if (wordCount == maxWordCount) {
                if (sender.compareTo(largestSender) > 0) {
                    largestSender = sender;
                }
            }
        }

        return largestSender;
    }
}