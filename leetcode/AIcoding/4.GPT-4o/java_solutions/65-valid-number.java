public class Solution {
    public boolean isNumber(String s) {
        s = s.trim();
        if (s.isEmpty()) return false;

        boolean numSeen = false, dotSeen = false, eSeen = false;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            char ch = s.charAt(i);
            if (Character.isDigit(ch)) {
                numSeen = true;
            } else if (ch == '.') {
                if (dotSeen || eSeen) return false;
                dotSeen = true;
            } else if (ch == 'e' || ch == 'E') {
                if (eSeen || !numSeen) return false;
                eSeen = true;
                numSeen = false; // Reset numSeen for the exponent part
            } else if (ch == '+' || ch == '-') {
                if (i > 0 && s.charAt(i - 1) != 'e' && s.charAt(i - 1) != 'E') return false;
            } else {
                return false;
            }
        }
        return numSeen;
    }
}