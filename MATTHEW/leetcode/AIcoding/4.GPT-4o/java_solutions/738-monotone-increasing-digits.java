class Solution {
    public int monotoneIncreasingDigits(int N) {
        char[] digits = Integer.toString(N).toCharArray();
        int n = digits.length;
        int mark = n;

        for (int i = n - 1; i > 0; i--) {
            if (digits[i] < digits[i - 1]) {
                mark = i;
                digits[i - 1]--;
            }
        }

        for (int i = mark; i < n; i++) {
            digits[i] = '9';
        }

        return Integer.parseInt(new String(digits));
    }
}