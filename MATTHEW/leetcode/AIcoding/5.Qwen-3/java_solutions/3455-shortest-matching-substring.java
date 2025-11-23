public class Solution {

import java.util.*;

public class Solution {
    public String shortestSubstring(String s, String[] queries) {
        List<String> result = new ArrayList<>();
        for (String query : queries) {
            result.add(findShortest(s, query));
        }
        return String.join(",", result);
    }

    private String findShortest(String s, String target) {
        int n = s.length();
        int m = target.length();
        if (m == 0 || n < m) return "";
        Set<Character> targetChars = new HashSet<>();
        for (char c : target.toCharArray()) {
            targetChars.add(c);
        }
        int[] count = new int[256];
        int required = targetChars.size();
        int formed = 0;
        int left = 0, right = 0;
        int minLen = Integer.MAX_VALUE;
        String minSubstring = "";

        while (right < n) {
            char rChar = s.charAt(right);
            if (targetChars.contains(rChar)) {
                count[rChar]++;
                if (count[rChar] == 1) {
                    formed++;
                }
            }
            right++;

            while (formed == required) {
                int windowSize = right - left;
                if (windowSize < minLen) {
                    minLen = windowSize;
                    minSubstring = s.substring(left, right);
                }

                char lChar = s.charAt(left);
                if (targetChars.contains(lChar)) {
                    count[lChar]--;
                    if (count[lChar] == 0) {
                        formed--;
                    }
                }
                left++;
            }
        }

        return minSubstring;
    }
}
}