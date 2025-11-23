import java.util.HashMap;
import java.util.Map;

class Solution {
    public String senderWithLargestWordCount(String[] messages, String[] senders) {
        Map<String, Integer> senderWordCounts = new HashMap<>();

        for (int i = 0; i < messages.length; i++) {
            String sender = senders[i];
            String message = messages[i];
            int wordCount = message.split(" ").length;
            senderWordCounts.put(sender, senderWordCounts.getOrDefault(sender, 0) + wordCount);
        }

        String resultSender = "";
        int maxWordCount = 0;

        for (Map.Entry<String, Integer> entry : senderWordCounts.entrySet()) {
            String currentSender = entry.getKey();
            int currentWordCount = entry.getValue();

            if (currentWordCount > maxWordCount) {
                maxWordCount = currentWordCount;
                resultSender = currentSender;
            } else if (currentWordCount == maxWordCount) {
                if (currentSender.compareTo(resultSender) > 0) {
                    resultSender = currentSender;
                }
            }
        }

        return resultSender;
    }
}