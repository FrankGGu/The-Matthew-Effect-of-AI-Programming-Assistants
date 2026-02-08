class Solution {
    public boolean isNumber(String s) {
        s = s.trim();

        boolean seenDigit = false;
        boolean seenDot = false;
        boolean seenE = false;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);

            if (Character.isDigit(c)) {
                seenDigit = true;
            } else if (c == '.') {
                // A dot is invalid if we've already seen one, or if we've seen 'e'
                if (seenDot || seenE) {
                    return false;
                }
                seenDot = true;
            } else if (c == 'e' || c == 'E') {
                // 'e' is invalid if we've already seen one, or if no digits came before it
                if (seenE || !seenDigit) {
                    return false;
                }
                seenE = true;
                // Reset seenDigit for the exponent part (must have digits after 'e')
                seenDigit = false; 
            } else if (c == '+' || c == '-') {
                // A sign is only valid at the beginning of the string, or immediately after 'e'/'E'
                if (i != 0 && s.charAt(i - 1) != 'e' && s.charAt(i - 1) != 'E') {
                    return false;
                }
            } else {
                // Any other character is invalid
                return false;
            }
        }

        // After iterating, we must have seen at least one digit
        return seenDigit;
    }
}