import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int longestPalindrome(String[] words) {
        Map<String, Integer> count = new HashMap<>();
        int pairs = 0, single = 0;

        for (String word : words) {
            count.put(word, count.getOrDefault(word, 0) + 1);
        }

        for (String word : count.keySet()) {
            String reversed = new StringBuilder(word).reverse().toString();
            if (word.equals(reversed)) {
                pairs += count.get(word) / 2;
                if (count.get(word) % 2 == 1) {
                    single = 1;
                }
            } else if (count.containsKey(reversed)) {
                pairs += Math.min(count.get(word), count.get(reversed));
            }
        }

        return pairs * 4 + single * 2;
    }
}