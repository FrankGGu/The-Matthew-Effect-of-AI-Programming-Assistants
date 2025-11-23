class Solution {
    public String largestGoodInteger(String num) {
        char maxDigitChar = ' ';

        for (int i = 0; i <= num.length() - 3; i++) {
            char c1 = num.charAt(i);
            char c2 = num.charAt(i + 1);
            char c3 = num.charAt(i + 2);

            if (c1 == c2 && c2 == c3) {
                if (c1 > maxDigitChar) {
                    maxDigitChar = c1;
                }
            }
        }

        if (maxDigitChar == ' ') {
            return "";
        } else {
            return "" + maxDigitChar + maxDigitChar + maxDigitChar;
        }
    }
}