public class Solution {
    public boolean isNumber(String s) {
        s = s.trim();
        boolean hasDigit = false;
        boolean hasE = false;
        boolean hasDot = false;
        boolean hasSign = false;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (c == '.') {
                if (hasDot || hasE) return false;
                hasDot = true;
            } else if (c == 'e' || c == 'E') {
                if (hasE || !hasDigit) return false;
                hasE = true;
                hasDigit = false;
                hasSign = false;
                hasDot = false;
            } else if (c == '+' || c == '-') {
                if (hasSign || hasDigit || hasDot) {
                    if (s.charAt(i - 1) != 'e' && s.charAt(i - 1) != 'E') return false;
                }
                hasSign = true;
            } else {
                return false;
            }
        }

        return hasDigit;
    }
}