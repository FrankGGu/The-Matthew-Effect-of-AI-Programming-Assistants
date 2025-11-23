class Solution {
    public String shortestPalindrome(String s) {
        String rev = new StringBuilder(s).reverse().toString();
        String combined = s + "#" + rev;
        int[] lps = computeLPS(combined);
        int longest = lps[lps.length - 1];
        String toAdd = s.substring(longest);
        return new StringBuilder(toAdd).reverse().toString() + s;
    }

    private int[] computeLPS(String s) {
        int[] lps = new int[s.length()];
        int len = 0;
        int i = 1;
        while (i < s.length()) {
            if (s.charAt(i) == s.charAt(len)) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }
}