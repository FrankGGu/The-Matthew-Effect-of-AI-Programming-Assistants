class Solution {
    public int countSubstrings(String s) {
        int count = 0;
        if (s == null || s.length() == 0) {
            return 0;
        }

        for (int i = 0; i < s.length(); i++) {
            // Odd length palindromes (center is i)
            count += expandAroundCenter(s, i, i);
            // Even length palindromes (center is i and i+1)
            count += expandAroundCenter(s, i, i + 1);
        }

        return count;
    }

    private int expandAroundCenter(String s, int left, int right) {
        int palindromesFound = 0;
        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
            palindromesFound++;
            left--;
            right++;
        }
        return palindromesFound;
    }
}