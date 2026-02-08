class Solution {
    public boolean checkPalindromeFormation(String a, String b) {
        return check(a, b) || check(b, a);
    }

    private boolean check(String a, String b) {
        int n = a.length();
        int i = 0;
        while (i < n / 2 && a.charAt(i) == b.charAt(n - 1 - i)) {
            i++;
        }
        if (i == n / 2) {
            return true;
        }
        return isPalindrome(a.substring(i, n - i)) || isPalindrome(b.substring(i, n - i));
    }

    private boolean isPalindrome(String s) {
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
}