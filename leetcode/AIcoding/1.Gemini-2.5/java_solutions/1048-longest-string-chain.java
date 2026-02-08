import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestStrChain(String[] words) {
        Arrays.sort(words, Comparator.comparingInt(String::length));

        Map<String, Integer> dp = new HashMap<>();
        int maxLength = 0;

        for (String word : words) {
            int currentChainLength = 1;
            for (int i = 0; i < word.length(); i++) {
                StringBuilder predecessorBuilder = new StringBuilder(word);
                predecessorBuilder.deleteCharAt(i);
                String predecessor = predecessorBuilder.toString();

                if (dp.containsKey(predecessor)) {
                    currentChainLength = Math.max(currentChainLength, dp.get(predecessor) + 1);
                }
            }
            dp.put(word, currentChainLength);
            maxLength = Math.max(maxLength, currentChainLength);
        }

        return maxLength;
    }
}