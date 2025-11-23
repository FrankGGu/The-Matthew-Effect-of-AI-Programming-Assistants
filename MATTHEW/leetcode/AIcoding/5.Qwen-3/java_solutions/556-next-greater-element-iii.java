public class Solution {
    public int nextGreaterElement(int n) {
        char[] digits = String.valueOf(n).toCharArray();
        int i = digits.length - 1;
        while (i > 0 && digits[i - 1] >= digits[i]) {
            i--;
        }
        if (i == 0) {
            return -1;
        }
        int j = digits.length - 1;
        while (digits[j] <= digits[i - 1]) {
            j--;
        }
        char temp = digits[i - 1];
        digits[i - 1] = digits[j];
        digits[j] = temp;
        reverse(digits, i, digits.length - 1);
        long result = Long.parseLong(new String(digits));
        return result > Integer.MAX_VALUE ? -1 : (int) result;
    }

    private void reverse(char[] digits, int start, int end) {
        while (start < end) {
            char temp = digits[start];
            digits[start++] = digits[end];
            digits[end--] = temp;
        }
    }
}