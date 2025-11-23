class Solution {
    public int myAtoi(String s) {
        int i = 0;
        int n = s.length();

        while (i < n && s.charAt(i) == ' ') {
            i++;
        }

        int sign = 1;
        if (i < n && (s.charAt(i) == '+' || s.charAt(i) == '-')) {
            sign = (s.charAt(i) == '-') ? -1 : 1;
            i++;
        }

        int result = 0;
        while (i < n && Character.isDigit(s.charAt(i))) {
            int digit = s.charAt(i) - '0';

            if (sign == 1) {
                if (result > Integer.MAX_VALUE / 10 || (result == Integer.MAX_VALUE / 10 && digit > 7)) {
                    return Integer.MAX_VALUE;
                }
            } else { // sign == -1
                // For negative numbers, Integer.MIN_VALUE is -2147483648.
                // Its absolute value is 2147483648, which is 1 greater than Integer.MAX_VALUE (2147483647).
                // So, if the absolute value being built exceeds 2147483648, it should be clamped to Integer.MIN_VALUE.
                // If it's exactly 2147483648, it should become Integer.MIN_VALUE.
                // The check `digit > 8` correctly handles this:
                // If current result is 214748364 and digit is 8, the value is 2147483648 (abs(MIN_VALUE)).
                // The condition `digit > 8` is false, so it proceeds to update result.
                // If current result is 214748364 and digit is 9, the value is 2147483649.
                // The condition `digit > 8` is true, so it correctly returns Integer.MIN_VALUE.
                if (result > Integer.MAX_VALUE / 10 || (result == Integer.MAX_VALUE / 10 && digit > 8)) {
                    return Integer.MIN_VALUE;
                }
            }

            result = result * 10 + digit;
            i++;
        }

        return result * sign;
    }
}