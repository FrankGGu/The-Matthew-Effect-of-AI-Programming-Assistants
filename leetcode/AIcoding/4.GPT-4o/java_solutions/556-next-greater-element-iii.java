class Solution {
    public int nextGreaterElement(int n) {
        char[] digits = String.valueOf(n).toCharArray();
        int len = digits.length;

        int i = len - 2;
        while (i >= 0 && digits[i] >= digits[i + 1]) {
            i--;
        }

        if (i < 0) return -1;

        int j = len - 1;
        while (digits[j] <= digits[i]) {
            j--;
        }

        char temp = digits[i];
        digits[i] = digits[j];
        digits[j] = temp;

        reverse(digits, i + 1, len - 1);

        long result = Long.parseLong(new String(digits));
        return result > Integer.MAX_VALUE ? -1 : (int)result;
    }

    private void reverse(char[] digits, int start, int end) {
        while (start < end) {
            char temp = digits[start];
            digits[start] = digits[end];
            digits[end] = temp;
            start++;
            end--;
        }
    }
}