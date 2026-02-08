class Solution {
    public String longestPrefix(String s) {
        int[] lps = computeLPSArray(s);
        return s.substring(0, lps[s.length() - 1]);
    }

    private int[] computeLPSArray(String str) {
        int n = str.length();
        int[] lps = new int[n];
        int len = 0;
        lps[0] = 0;
        int i = 1;
        while (i < n) {
            if (str.charAt(i) == str.charAt(len)) {
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