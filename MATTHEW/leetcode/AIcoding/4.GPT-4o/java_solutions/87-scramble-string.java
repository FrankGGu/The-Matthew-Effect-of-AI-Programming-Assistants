class Solution {
    public boolean isScramble(String s1, String s2) {
        if (s1.length() != s2.length()) return false;
        if (s1.equals(s2)) return true;

        int[] count = new int[26];
        for (char c : s1.toCharArray()) count[c - 'a']++;
        for (char c : s2.toCharArray()) {
            if (--count[c - 'a'] < 0) return false;
        }

        int n = s1.length();
        for (int len = 1; len < n; len++) {
            if (isScramble(s1.substring(0, len), s2.substring(0, len)) && 
                isScramble(s1.substring(len), s2.substring(len))) {
                return true;
            }
            if (isScramble(s1.substring(0, len), s2.substring(n - len)) && 
                isScramble(s1.substring(len), s2.substring(0, n - len))) {
                return true;
            }
        }

        return false;
    }
}