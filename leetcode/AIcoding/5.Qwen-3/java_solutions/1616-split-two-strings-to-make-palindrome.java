public class Solution {
    public boolean isPalindrome(String s) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    public boolean checkPalindromeFormation(String s, String t) {
        int n = s.length();
        int left = 0, right = n - 1;

        while (left < right && s.charAt(left) == t.charAt(right)) {
            left++;
            right--;
        }

        if (isPalindrome(s.substring(left, right + 1)) || isPalindrome(t.substring(left, right + 1))) {
            return true;
        }

        left = 0;
        right = n - 1;

        while (left < right && t.charAt(left) == s.charAt(right)) {
            left++;
            right--;
        }

        if (isPalindrome(s.substring(left, right + 1)) || isPalindrome(t.substring(left, right + 1))) {
            return true;
        }

        return false;
    }
}