class Solution {
    public int shiftDistance(String s, String t) {
        if (s.length() != t.length()) return -1;
        int n = s.length();
        if (s.equals(t)) return 0;

        for (int i = 1; i < n; i++) {
            String shifted = s.substring(i) + s.substring(0, i);
            if (shifted.equals(t)) return i;
        }

        return -1;
    }
}