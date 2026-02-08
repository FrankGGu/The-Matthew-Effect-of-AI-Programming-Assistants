public class Solution {
    public int numDifferentIntegers(String s) {
        boolean[] digits = new boolean[10];
        boolean[] leadingZero = new boolean[10];
        boolean[] hasNumber = new boolean[10];
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= '0' && c <= '9') {
                int digit = c - '0';
                if (!digits[digit]) {
                    digits[digit] = true;
                    count++;
                }
                hasNumber[digit] = true;
                if (i > 0 && s.charAt(i - 1) == '0' && !leadingZero[digit]) {
                    leadingZero[digit] = true;
                    count++;
                }
            } else {
                for (int j = 0; j < 10; j++) {
                    digits[j] = false;
                }
                for (int j = 0; j < 10; j++) {
                    leadingZero[j] = false;
                }
            }
        }
        for (int i = 0; i < 10; i++) {
            if (hasNumber[i]) {
                count++;
            }
        }
        return count;
    }
}