class Solution {
    public String shortestPalindrome(String s) {
        int n = s.length();
        String rev_s = new StringBuilder(s).reverse().toString();
        String combined = s + "#" + rev_s;
        int[] lps = kmpTable(combined);
        return new StringBuilder(rev_s.substring(0, n - lps[combined.length() - 1])).append(s).toString();
    }

    private int[] kmpTable(String w) {
        int n = w.length();
        int[] T = new int[n];
        int pos = 1;
        int cnd = 0;

        T[0] = 0;

        while (pos < n) {
            if (w.charAt(pos) == w.charAt(cnd)) {
                T[pos] = cnd + 1;
                pos++;
                cnd++;
            } else if (cnd > 0) {
                cnd = T[cnd - 1];
            } else {
                T[pos] = 0;
                pos++;
            }
        }
        return T;
    }
}