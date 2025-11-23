public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();
        if (s == null || p == null || s.length() < p.length()) {
            return result;
        }

        int[] count = new int[26];
        for (char c : p.toCharArray()) {
            count[c - 'a']++;
        }

        int left = 0;
        int right = 0;
        int len = p.length();
        int match = 0;

        while (right < s.length()) {
            char c = s.charAt(right);
            if (count[c - 'a'] > 0) {
                match++;
            }
            count[c - 'a']--;
            right++;

            if (right - left > len) {
                char leftChar = s.charAt(left);
                if (count[leftChar - 'a'] >= 0) {
                    match--;
                }
                count[leftChar - 'a']++;
                left++;
            }

            if (match == len) {
                result.add(left);
            }
        }

        return result;
    }
}
}