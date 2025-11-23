import java.util.*;

class Solution {
    public int longestStrChain(String[] words) {
        Set<String> wordSet = new HashSet<>(Arrays.asList(words));
        Map<String, Integer> dp = new HashMap<>();
        int maxChain = 0;

        Arrays.sort(words, (a, b) -> a.length() - b.length());

        for (String word : words) {
            dp.put(word, 1);
            for (int i = 0; i < word.length(); i++) {
                String predecessor = word.substring(0, i) + word.substring(i + 1);
                if (wordSet.contains(predecessor)) {
                    dp.put(word, Math.max(dp.get(word), dp.get(predecessor) + 1));
                }
            }
            maxChain = Math.max(maxChain, dp.get(word));
        }

        return maxChain;
    }
}