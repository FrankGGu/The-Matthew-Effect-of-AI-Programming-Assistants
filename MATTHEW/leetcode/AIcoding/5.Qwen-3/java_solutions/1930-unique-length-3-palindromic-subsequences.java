public class Solution {

import java.util.*;

public class Solution {
    public int countPalindromicSubsequence(String s) {
        int n = s.length();
        Set<Character> uniqueChars = new HashSet<>();
        for (char c : s.toCharArray()) {
            uniqueChars.add(c);
        }

        int result = 0;

        for (char c : uniqueChars) {
            int left = 0;
            int right = n - 1;
            while (left < n && s.charAt(left) != c) {
                left++;
            }
            while (right >= 0 && s.charAt(right) != c) {
                right--;
            }

            if (left < right) {
                Set<Character> middleChars = new HashSet<>();
                for (int i = left + 1; i < right; i++) {
                    middleChars.add(s.charAt(i));
                }
                result += middleChars.size();
            }
        }

        return result;
    }
}
}