class Solution {
    public String makeSmallestPalindrome(String s) {
        StringBuilder sb = new StringBuilder(s);
        int n = s.length();
        for (int i = 0; i < n / 2; i++) {
            char minChar = (char) Math.min(s.charAt(i), s.charAt(n - 1 - i));
            sb.setCharAt(i, minChar);
            sb.setCharAt(n - 1 - i, minChar);
        }
        return sb.toString();
    }
}