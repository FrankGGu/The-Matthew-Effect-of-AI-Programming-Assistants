import java.util.*;

class Solution {
    public String mostCommonWord(String paragraph, String[] banned) {
        Set<String> bannedWords = new HashSet<>(Arrays.asList(banned));
        Map<String, Integer> wordCounts = new HashMap<>();
        String cleanedParagraph = paragraph.replaceAll("[^a-zA-Z]", " ").toLowerCase();
        String[] words = cleanedParagraph.split("\\s+");

        for (String word : words) {
            if (!word.isEmpty() && !bannedWords.contains(word)) {
                wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
            }
        }

        String mostCommon = "";
        int maxCount = 0;
        for (Map.Entry<String, Integer> entry : wordCounts.entrySet()) {
            if (entry.getValue() > maxCount) {
                mostCommon = entry.getKey();
                maxCount = entry.getValue();
            }
        }

        return mostCommon;
    }
}