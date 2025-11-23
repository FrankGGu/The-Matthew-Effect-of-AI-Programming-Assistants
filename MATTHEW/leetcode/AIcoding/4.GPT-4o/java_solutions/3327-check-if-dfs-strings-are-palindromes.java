class Solution {
    public boolean checkPalindrome(String s) {
        int left = 0, right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    public boolean arePalindromeStrings(String s1, String s2) {
        return checkPalindrome(s1) && checkPalindrome(s2);
    }
}