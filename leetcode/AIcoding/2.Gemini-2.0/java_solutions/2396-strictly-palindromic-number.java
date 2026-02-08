class Solution {
    public boolean isStrictlyPalindromic(int n) {
        for (int base = 2; base <= n - 2; base++) {
            String baseN = Integer.toString(n, base);
            if (!isPalindrome(baseN)) {
                return false;
            }
        }
        return true;
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