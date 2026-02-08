class Solution {
    public String reformatNumber(String s) {
        StringBuilder cleanedDigits = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                cleanedDigits.append(c);
            }
        }

        String digits = cleanedDigits.toString();
        int n = digits.length();
        StringBuilder result = new StringBuilder();

        int i = 0;
        while (i < n) {
            int remainingDigits = n - i;

            if (remainingDigits > 4) {
                // If more than 4 digits remain, always take a block of 3
                result.append(digits.substring(i, i + 3));
                result.append('-');
                i += 3;
            } else if (remainingDigits == 4) {
                // If exactly 4 digits remain, form two blocks of 2
                result.append(digits.substring(i, i + 2));
                result.append('-');
                result.append(digits.substring(i + 2, i + 4));
                i += 4; // All digits processed
            } else if (remainingDigits == 3) {
                // If exactly 3 digits remain, form one block of 3
                result.append(digits.substring(i, i + 3));
                i += 3; // All digits processed
            } else if (remainingDigits == 2) {
                // If exactly 2 digits remain, form one block of 2
                result.append(digits.substring(i, i + 2));
                i += 2; // All digits processed
            } else if (remainingDigits == 1) {
                // This case should ideally not happen if problem rules are strictly followed
                // (blocks must be length 2 or 3). However, if n=1 is input, this handles it.
                result.append(digits.substring(i, i + 1));
                i += 1; // All digits processed
            }
        }

        return result.toString();
    }
}