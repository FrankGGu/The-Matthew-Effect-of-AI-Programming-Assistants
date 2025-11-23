public class Solution {
    public boolean movePieces(String s, String t) {
        int i = 0, j = 0;
        while (i < s.length() || j < t.length()) {
            while (i < s.length() && s.charAt(i) == ' ') i++;
            while (j < t.length() && t.charAt(j) == ' ') j++;
            if (i >= s.length() || j >= t.length()) return i == j;
            if (s.charAt(i) != t.charAt(j)) return false;
            if (s.charAt(i) == 'L' && i < j) return false;
            if (s.charAt(i) == 'R' && i > j) return false;
            i++;
            j++;
        }
        return true;
    }
}