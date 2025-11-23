public class Solution {
    public int monotoneIncreasingDigits(int n) {
        char[] digits = String.valueOf(n).toCharArray();
        int i = 0;
        while (i < digits.length - 1 && digits[i] <= digits[i + 1]) {
            i++;
        }
        if (i == digits.length - 1) {
            return n;
        }
        while (i >= 0 && digits[i] > digits[i + 1]) {
            digits[i]--;
            i--;
        }
        for (i++; i < digits.length; i++) {
            digits[i] = '9';
        }
        return Integer.parseInt(new String(digits));
    }
}