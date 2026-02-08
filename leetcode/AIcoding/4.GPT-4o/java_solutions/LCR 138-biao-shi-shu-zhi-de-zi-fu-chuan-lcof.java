class Solution {
    public boolean isNumber(String s) {
        s = s.trim();
        if (s.isEmpty()) return false;

        boolean hasNum = false, hasDot = false, hasE = false;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                hasNum = true;
            } else if (c == '.') {
                if (hasDot || hasE) return false;
                hasDot = true;
            } else if (c == 'e' || c == 'E') {
                if (hasE || !hasNum) return false;
                hasE = true;
                hasNum = false; // reset for the exponent part
            } else if (c == '+' || c == '-') {
                if (i > 0 && s.charAt(i - 1) != 'e' && s.charAt(i - 1) != 'E') return false;
            } else {
                return false;
            }
        }
        return hasNum;
    }
}