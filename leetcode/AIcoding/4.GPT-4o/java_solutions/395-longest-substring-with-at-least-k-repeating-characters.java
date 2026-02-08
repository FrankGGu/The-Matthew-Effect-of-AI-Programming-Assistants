import java.util.HashMap;

public class Solution {
    public int longestSubstring(String s, int k) {
        return longestSubstringHelper(s, 0, s.length(), k);
    }

    private int longestSubstringHelper(String s, int start, int end, int k) {
        if (end - start < k) return 0;

        HashMap<Character, Integer> countMap = new HashMap<>();
        for (int i = start; i < end; i++) {
            countMap.put(s.charAt(i), countMap.getOrDefault(s.charAt(i), 0) + 1);
        }

        for (char c : countMap.keySet()) {
            if (countMap.get(c) < k) {
                int maxLength = 0;
                for (int i = start; i < end; i++) {
                    if (s.charAt(i) == c) {
                        maxLength = Math.max(maxLength, longestSubstringHelper(s, start, i, k));
                        start = i + 1;
                    }
                }
                maxLength = Math.max(maxLength, longestSubstringHelper(s, start, end, k));
                return maxLength;
            }
        }
        return end - start;
    }
}