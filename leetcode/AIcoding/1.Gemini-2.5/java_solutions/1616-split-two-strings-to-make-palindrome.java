class Solution {
    public boolean checkPalindromeFormation(String a, String b) {
        return check(a, b) || check(b, a);
    }

    private boolean check(String s1, String s2) {
        int n = s1.length();
        int i = 0, j = n - 1;

        while (i < j && s1.charAt(i) == s2.charAt(j)) {
            i++;
            j--;
        }

        return isPalindrome(s1, i, j) || isPalindrome(s2, i, j);
    }

    private boolean isPalindrome(String s, int left, int right) {
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