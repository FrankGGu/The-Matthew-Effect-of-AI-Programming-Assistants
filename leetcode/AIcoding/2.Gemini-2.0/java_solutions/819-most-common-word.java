import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public String mostCommonWord(String paragraph, String[] banned) {
        Set<String> bannedWords = new HashSet<>();
        for (String word : banned) {
            bannedWords.add(word);
        }

        Map<String, Integer> wordCounts = new HashMap<>();
        String word = "";
        int maxCount = 0;
        String mostCommon = "";

        for (int i = 0; i < paragraph.length(); i++) {
            char c = paragraph.charAt(i);
            if (Character.isLetter(c)) {
                word += Character.toLowerCase(c);
            } else {
                if (!word.isEmpty()) {
                    if (!bannedWords.contains(word)) {
                        wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
                        if (wordCounts.get(word) > maxCount) {
                            maxCount = wordCounts.get(word);
                            mostCommon = word;
                        }
                    }
                    word = "";
                }
            }
        }

        if (!word.isEmpty()) {
            if (!bannedWords.contains(word)) {
                wordCounts.put(word, wordCounts.getOrDefault(word, 0) + 1);
                if (wordCounts.get(word) > maxCount) {
                    maxCount = wordCounts.get(word);
                    mostCommon = word;
                }
            }
        }

        return mostCommon;
    }
}