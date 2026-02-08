class Solution {
    public int countSubstrings(String s) {
        int n = s.length();
        int count = 0;

        for (int i = 0; i < n; i++) {
            // Odd length palindromes (center at i)
            count += expandAroundCenter(s, i, i);
            // Even length palindromes (center between i and i+1)
            count += expandAroundCenter(s, i, i + 1);
        }

        return count;
    }

    private int expandAroundCenter(String s, int left, int right) {
        int currentCount = 0;
        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
            currentCount++;
            left--;
            right++;
        }
        return currentCount;
    }
}