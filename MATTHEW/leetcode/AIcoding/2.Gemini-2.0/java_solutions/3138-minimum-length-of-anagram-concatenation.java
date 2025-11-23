import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minAnagramLength(String s, String t) {
        if (s == null || s.isEmpty() || t == null || t.isEmpty()) {
            return -1;
        }

        Map<Character, Integer> targetFreq = new HashMap<>();
        for (char c : t.toCharArray()) {
            targetFreq.put(c, targetFreq.getOrDefault(c, 0) + 1);
        }

        int windowStart = 0;
        int matched = 0;
        int minLength = Integer.MAX_VALUE;
        Map<Character, Integer> windowFreq = new HashMap<>();

        for (int windowEnd = 0; windowEnd < s.length(); windowEnd++) {
            char rightChar = s.charAt(windowEnd);
            windowFreq.put(rightChar, windowFreq.getOrDefault(rightChar, 0) + 1);

            if (targetFreq.containsKey(rightChar) && windowFreq.get(rightChar).equals(targetFreq.get(rightChar))) {
                matched++;
            }

            while (matched == targetFreq.size()) {
                if (windowEnd - windowStart + 1 < minLength) {
                    minLength = windowEnd - windowStart + 1;
                }

                char leftChar = s.charAt(windowStart);
                windowFreq.put(leftChar, windowFreq.get(leftChar) - 1);

                if (targetFreq.containsKey(leftChar) && windowFreq.get(leftChar) < targetFreq.get(leftChar)) {
                    matched--;
                }

                windowStart++;
            }
        }

        return minLength == Integer.MAX_VALUE ? -1 : minLength;
    }
}