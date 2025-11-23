class Solution {
    public String shortestPalindrome(String s) {
        if (s == null || s.length() == 0) {
            return "";
        }

        String rev_s = new StringBuilder(s).reverse().toString();
        // Construct the KMP pattern: s + "#" + reverse(s)
        // The '#' is a delimiter to prevent prefixes of s from matching suffixes of s
        // across the boundary, which are not relevant to the palindrome check.
        String temp = s + "#" + rev_s;

        // Compute the LPS (Longest Proper Prefix which is also Suffix) array for temp
        int[] lps = computeLPSArray(temp);

        // The last element of the LPS array (lps[temp.length() - 1])
        // gives the length of the longest prefix of 's' that is also a suffix of 'reverse(s)'.
        // This is exactly the length of the longest palindromic prefix of 's'.
        int longestPalindromicPrefixLength = lps[temp.length() - 1];

        // The characters in 's' that are NOT part of this longest palindromic prefix
        // need to be reversed and prepended to 's' to form the shortest palindrome.
        // These characters are s.substring(longestPalindromicPrefixLength).
        String suffixToPrepend = s.substring(longestPalindromicPrefixLength);

        // Reverse this suffix and prepend it to the original string 's'.
        return new StringBuilder(suffixToPrepend).reverse().toString() + s;
    }

    // KMP algorithm's LPS array computation
    private int[] computeLPSArray(String pattern) {
        int m = pattern.length();
        int[] lps = new int[m];
        int length = 0; // length of the previous longest prefix suffix

        // lps[0] is always 0
        lps[0] = 0;

        // the loop calculates lps[i] for i = 1 to m-1
        int i = 1;
        while (i < m) {
            if (pattern.charAt(i) == pattern.charAt(length)) {
                length++;
                lps[i] = length;
                i++;
            } else { // (pattern.charAt(i) != pattern.charAt(length))
                // This is tricky. We don't match pattern[i] with pattern[0].
                // We look for the next shortest prefix suffix.
                if (length != 0) {
                    length = lps[length - 1];
                } else { // if (length == 0)
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }
}