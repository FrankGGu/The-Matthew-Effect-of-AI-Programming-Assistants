public class Solution {

import java.util.*;

public class Solution {
    public int longestPalindrome(String[] words) {
        Map<String, Integer> count = new HashMap<>();
        for (String word : words) {
            count.put(word, count.getOrDefault(word, 0) + 1);
        }

        int result = 0;
        boolean hasMiddle = false;

        for (Map.Entry<String, Integer> entry : count.entrySet()) {
            String word = entry.getKey();
            int freq = entry.getValue();

            if (word.charAt(0) == word.charAt(1)) {
                int pairs = freq / 2;
                result += pairs * 2;
                if (freq % 2 == 1 && !hasMiddle) {
                    hasMiddle = true;
                }
            } else {
                String reversed = new StringBuilder(word).reverse().toString();
                if (count.containsKey(reversed)) {
                    int pairs = Math.min(freq, count.get(reversed));
                    result += pairs * 2;
                    count.put(reversed, 0);
                }
            }
        }

        if (hasMiddle) {
            result += 2;
        }

        return result;
    }
}
}