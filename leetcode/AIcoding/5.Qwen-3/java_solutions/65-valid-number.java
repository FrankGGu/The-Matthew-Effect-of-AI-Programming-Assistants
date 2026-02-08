public class Solution {
    public boolean isNumber(String s) {
        if (s == null || s.trim().length() == 0) return false;
        s = s.trim();
        boolean hasDigit = false;
        boolean hasExponent = false;
        boolean hasSign = false;
        boolean hasDot = false;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= '0' && c <= '9') {
                hasDigit = true;
            } else if (c == '+' || c == '-') {
                if (hasSign || hasDigit || hasDot || i > 0 && s.charAt(i - 1) != 'e' && s.charAt(i - 1) != 'E') {
                    return false;
                }
                hasSign = true;
            } else if (c == 'e' || c == 'E') {
                if (hasExponent || !hasDigit) {
                    return false;
                }
                hasExponent = true;
                hasSign = false;
                hasDot = false;
                hasDigit = false;
            } else if (c == '.') {
                if (hasDot || hasExponent) {
                    return false;
                }
                hasDot = true;
            } else {
                return false;
            }
        }
        return hasDigit;
    }
}