public class Solution {
    public boolean isNumber(String s) {
        if (s == null || s.trim().length() == 0) {
            return false;
        }
        s = s.trim();
        boolean hasDigit = false;
        boolean hasExponent = false;
        boolean hasDot = false;
        boolean hasSign = false;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == 'e' || c == 'E') {
                if (hasExponent || !hasDigit) {
                    return false;
                }
                hasExponent = true;
                hasDigit = false;
                hasSign = false;
                hasDot = false;
            } else if (c == '+' || c == '-') {
                if (hasSign || hasDigit || i > 0 && s.charAt(i - 1) != 'e' && s.charAt(i - 1) != 'E') {
                    return false;
                }
                hasSign = true;
            } else if (c == '.') {
                if (hasDot || hasExponent) {
                    return false;
                }
                hasDot = true;
            } else if (c < '0' || c > '9') {
                return false;
            } else {
                hasDigit = true;
            }
        }
        return hasDigit;
    }
}