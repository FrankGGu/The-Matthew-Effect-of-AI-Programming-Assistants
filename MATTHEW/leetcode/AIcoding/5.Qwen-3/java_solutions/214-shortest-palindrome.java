public class Solution {
    public String shortestPalindrome(String s) {
        String temp = s + "$" + new StringBuilder(s).reverse().toString();
        int[] lps = new int[temp.length()];
        for (int i = 1; i < temp.length(); i++) {
            int j = lps[i - 1];
            while (j > 0 && temp.charAt(i) != temp.charAt(j)) {
                j = lps[j - 1];
            }
            if (temp.charAt(i) == temp.charAt(j)) {
                j++;
            }
            lps[i] = j;
        }
        return new StringBuilder(s.substring(lps[lps.length - 1])).reverse().toString() + s;
    }
}