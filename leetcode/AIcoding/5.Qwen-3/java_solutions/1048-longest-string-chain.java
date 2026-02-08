public class Solution {

import java.util.*;

public class Solution {
    public int longestStrChain(String[] words) {
        Arrays.sort(words, (a, b) -> a.length() - b.length());
        Map<String, Integer> dp = new HashMap<>();
        int maxLen = 1;

        for (String word : words) {
            dp.put(word, 1);
            for (int i = 0; i < word.length(); i++) {
                String prev = word.substring(0, i) + word.substring(i + 1);
                if (dp.containsKey(prev)) {
                    dp.put(word, Math.max(dp.get(word), dp.get(prev) + 1));
                }
            }
            maxLen = Math.max(maxLen, dp.get(word));
        }

        return maxLen;
    }
}
}