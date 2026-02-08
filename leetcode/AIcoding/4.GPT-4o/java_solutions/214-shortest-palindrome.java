public class Solution {
    public String shortestPalindrome(String s) {
        String rev = new StringBuilder(s).reverse().toString();
        String l = s + "#" + rev;
        int[] lps = new int[l.length()];
        for (int i = 1; i < l.length(); i++) {
            int j = lps[i - 1];
            while (j > 0 && l.charAt(i) != l.charAt(j)) {
                j = lps[j - 1];
            }
            if (l.charAt(i) == l.charAt(j)) {
                j++;
            }
            lps[i] = j;
        }
        return rev.substring(0, s.length() - lps[l.length() - 1]) + s;
    }
}