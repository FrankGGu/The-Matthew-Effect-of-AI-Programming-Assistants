class Solution {
    int maxLen = 0;
    int start = 0;

    public String longestPalindrome(String s) {
        if (s == null || s.length() < 1) {
            return "";
        }

        for (int i = 0; i < s.length(); i++) {
            expandAroundCenter(s, i, i);     // Odd length palindromes
            expandAroundCenter(s, i, i + 1); // Even length palindromes
        }

        return s.substring(start, start + maxLen);
    }

    private void expandAroundCenter(String s, int left, int right) {
        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
            left--;
            right++;
        }
        // At this point, s[left+1 ... right-1] is a palindrome.
        // Its length is (right-1) - (left+1) + 1 = right - left - 1.
        int currentLen = right - left - 1;
        if (currentLen > maxLen) {
            maxLen = currentLen;
            start = left + 1;
        }
    }
}