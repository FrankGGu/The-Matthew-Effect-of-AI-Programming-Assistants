class Solution {
    public boolean isNumber(String s) {
        s = s.trim();
        if (s.isEmpty()) {
            return false;
        }

        boolean seenDigit = false;
        boolean seenDot = false;
        boolean seenE = false;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);

            if (Character.isDigit(c)) {
                seenDigit = true;
            } else if (c == '+' || c == '-') {
                // Sign can only appear at the beginning or immediately after 'e'/'E'
                if (i != 0 && s.charAt(i - 1) != 'e' && s.charAt(i - 1) != 'E') {
                    return false;
                }
            } else if (c == '.') {
                // Decimal point cannot appear after 'e'/'E' or if already seen
                if (seenE || seenDot) {
                    return false;
                }
                seenDot = true;
            } else if (c == 'e' || c == 'E') {
                // 'e'/'E' cannot appear if already seen or if no digit before it
                if (seenE || !seenDigit) {
                    return false;
                }
                seenE = true;
                seenDigit = false; // Reset seenDigit for the exponent part (must have digits after 'e')
            } else {
                // Any other character is invalid
                return false;
            }
        }

        // After iterating, there must be at least one digit
        return seenDigit;
    }
}