import java.util.HashMap;
import java.util.Map;

class Solution {
    public String minWindow(String s, String t) {
        if (s == null || t == null || s.length() == 0 || t.length() == 0) {
            return "";
        }

        Map<Character, Integer> targetCharCounts = new HashMap<>();
        for (char c : t.toCharArray()) {
            targetCharCounts.put(c, targetCharCounts.getOrDefault(c, 0) + 1);
        }

        int requiredMatches = targetCharCounts.size();
        int currentMatches = 0;

        Map<Character, Integer> windowCharCounts = new HashMap<>();

        int minLen = Integer.MAX_VALUE;
        int minStart = 0;

        int left = 0;
        for (int right = 0; right < s.length(); right++) {
            char charR = s.charAt(right);

            if (targetCharCounts.containsKey(charR)) {
                windowCharCounts.put(charR, windowCharCounts.getOrDefault(charR, 0) + 1);
                if (windowCharCounts.get(charR).intValue() == targetCharCounts.get(charR).intValue()) {
                    currentMatches++;
                }
            }

            while (currentMatches == requiredMatches) {
                int currentWindowLen = right - left + 1;
                if (currentWindowLen < minLen) {
                    minLen = currentWindowLen;
                    minStart = left;
                }

                char charL = s.charAt(left);
                if (targetCharCounts.containsKey(charL)) {
                    windowCharCounts.put(charL, windowCharCounts.get(charL) - 1);
                    if (windowCharCounts.get(charL).intValue() < targetCharCounts.get(charL).intValue()) {
                        currentMatches--;
                    }
                }
                left++;
            }
        }

        return minLen == Integer.MAX_VALUE ? "" : s.substring(minStart, minStart + minLen);
    }
}