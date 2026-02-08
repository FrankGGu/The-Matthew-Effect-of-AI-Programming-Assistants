import java.util.HashSet;
import java.util.Set;

class Solution {
    public int countPalindromicSubsequences(String s) {
        int totalUniquePalindromes = 0;

        for (char c = 'a'; c <= 'z'; c++) {
            int firstIdx = -1;
            int lastIdx = -1;

            for (int i = 0; i < s.length(); i++) {
                if (s.charAt(i) == c) {
                    firstIdx = i;
                    break;
                }
            }

            if (firstIdx == -1) {
                continue;
            }

            for (int i = s.length() - 1; i >= 0; i--) {
                if (s.charAt(i) == c) {
                    lastIdx = i;
                    break;
                }
            }

            if (firstIdx == lastIdx) {
                continue;
            }

            Set<Character> uniqueMiddleChars = new HashSet<>();
            for (int i = firstIdx + 1; i < lastIdx; i++) {
                uniqueMiddleChars.add(s.charAt(i));
            }

            totalUniquePalindromes += uniqueMiddleChars.size();
        }

        return totalUniquePalindromes;
    }
}