import java.util.*;

public class Solution {
    public List<Integer> shortestSupersequence(String s, List<String> words) {
        Map<String, Integer> wordCount = new HashMap<>();
        for (String word : words) {
            wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
        }

        int required = wordCount.size();
        int left = 0, right = 0, formed = 0;
        Map<String, Integer> windowCounts = new HashMap<>();
        int minLen = Integer.MAX_VALUE;
        List<Integer> result = new ArrayList<>();

        while (right < s.length()) {
            char c = s.charAt(right);
            String word = String.valueOf(c);
            if (wordCount.containsKey(word)) {
                windowCounts.put(word, windowCounts.getOrDefault(word, 0) + 1);
                if (windowCounts.get(word).intValue() == wordCount.get(word).intValue()) {
                    formed++;
                }
            }

            while (left <= right && formed == required) {
                if (right - left + 1 < minLen) {
                    minLen = right - left + 1;
                    result.clear();
                    result.add(left);
                    result.add(right);
                }
                char lChar = s.charAt(left);
                String lWord = String.valueOf(lChar);
                if (windowCounts.containsKey(lWord)) {
                    windowCounts.put(lWord, windowCounts.get(lWord) - 1);
                    if (windowCounts.get(lWord).intValue() < wordCount.get(lWord).intValue()) {
                        formed--;
                    }
                }
                left++;
            }
            right++;
        }

        return result;
    }
}