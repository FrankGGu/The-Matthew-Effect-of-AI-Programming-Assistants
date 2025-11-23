public class Solution {
    public boolean possiblyEquals(String s, String t) {
        return possiblyEquals(s, t, 0, 0, 0);
    }

    private boolean possiblyEquals(String s, String t, int i, int j, int diff) {
        if (i == s.length() && j == t.length()) {
            return diff == 0;
        }
        if (i < s.length() && j < t.length() && s.charAt(i) == t.charAt(j)) {
            return possiblyEquals(s, t, i + 1, j + 1, diff);
        }
        if (i < s.length() && Character.isDigit(s.charAt(i))) {
            int num = 0;
            while (i < s.length() && Character.isDigit(s.charAt(i))) {
                num = num * 10 + (s.charAt(i) - '0');
                i++;
            }
            for (int k = i; k <= s.length(); k++) {
                if (possiblyEquals(s, t, k, j, diff + num)) {
                    return true;
                }
            }
        }
        if (j < t.length() && Character.isDigit(t.charAt(j))) {
            int num = 0;
            while (j < t.length() && Character.isDigit(t.charAt(j))) {
                num = num * 10 + (t.charAt(j) - '0');
                j++;
            }
            for (int k = j; k <= t.length(); k++) {
                if (possiblyEquals(s, t, i, k, diff - num)) {
                    return true;
                }
            }
        }
        return false;
    }
}