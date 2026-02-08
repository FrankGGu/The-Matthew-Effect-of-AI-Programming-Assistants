import java.util.HashMap;
import java.util.Map;

class Solution {
    public int rearrangeCharacters(String s, String target) {
        Map<Character, Integer> charCount = new HashMap<>();
        for (char c : s.toCharArray()) {
            charCount.put(c, charCount.getOrDefault(c, 0) + 1);
        }

        int minCount = Integer.MAX_VALUE;
        for (char c : target.toCharArray()) {
            if (!charCount.containsKey(c)) {
                return 0;
            }
            minCount = Math.min(minCount, charCount.get(c) / (target.length() - target.replace(String.valueOf(c), "").length()));
        }

        return minCount;
    }
}