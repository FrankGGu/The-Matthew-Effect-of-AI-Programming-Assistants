class Solution {
    public String longestPalindrome(String s) {
        int n = s.length();
        if (n < 2) return s;

        String longest = "";
        for (int i = 0; i < n; i++) {
            String odd = expandAroundCenter(s, i, i);
            String even = expandAroundCenter(s, i, i + 1);
            longest = longest.length() > odd.length() ? longest : odd;
            longest = longest.length() > even.length() ? longest : even;
        }
        return longest;
    }

    private String expandAroundCenter(String s, int left, int right) {
        while (left >= 0 && right < s.length() && s.charAt(left) == s.charAt(right)) {
            left--;
            right++;
        }
        return s.substring(left + 1, right);
    }
}