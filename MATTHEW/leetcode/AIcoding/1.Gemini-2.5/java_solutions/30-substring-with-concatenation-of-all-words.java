import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<Integer> findSubstring(String s, String[] words) {
        List<Integer> result = new ArrayList<>();
        if (s == null || s.length() == 0 || words == null || words.length == 0) {
            return result;
        }

        int wordLength = words[0].length();
        int numWords = words.length;
        int totalLength = wordLength * numWords;

        if (s.length() < totalLength) {
            return result;
        }

        Map<String, Integer> wordFrequencies = new HashMap<>();
        for (String word : words) {
            wordFrequencies.put(word, wordFrequencies.getOrDefault(word, 0) + 1);
        }

        for (int i = 0; i < wordLength; i++) {
            int left = i;
            int count = 0;
            Map<String, Integer> currentWindowFrequencies = new HashMap<>();

            for (int j = i; j <= s.length() - wordLength; j += wordLength) {
                String currentWord = s.substring(j, j + wordLength);

                if (wordFrequencies.containsKey(currentWord)) {
                    currentWindowFrequencies.put(currentWord, currentWindowFrequencies.getOrDefault(currentWord, 0) + 1);
                    count++;

                    while (currentWindowFrequencies.get(currentWord) > wordFrequencies.get(currentWord)) {
                        String leftWord = s.substring(left, left + wordLength);
                        currentWindowFrequencies.put(leftWord, currentWindowFrequencies.get(leftWord) - 1);
                        count--;
                        left += wordLength;
                    }

                    if (count == numWords) {
                        result.add(left);
                        String leftWord = s.substring(left, left + wordLength);
                        currentWindowFrequencies.put(leftWord, currentWindowFrequencies.get(leftWord) - 1);
                        count--;
                        left += wordLength;
                    }
                } else {
                    currentWindowFrequencies.clear();
                    count = 0;
                    left = j + wordLength;
                }
            }
        }

        return result;
    }
}