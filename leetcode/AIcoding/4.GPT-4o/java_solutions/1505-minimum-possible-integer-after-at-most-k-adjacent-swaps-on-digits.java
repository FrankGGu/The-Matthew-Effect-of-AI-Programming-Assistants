public class Solution {
    public String minInteger(String num, int k) {
        char[] digits = num.toCharArray();
        int n = digits.length;
        for (int i = 0; i < n && k > 0; i++) {
            char minChar = digits[i];
            int minIndex = i;
            for (int j = i + 1; j < n && j - i <= k; j++) {
                if (digits[j] < minChar) {
                    minChar = digits[j];
                    minIndex = j;
                }
            }
            for (int j = minIndex; j > i; j--) {
                digits[j] = digits[j - 1];
                k--;
            }
            digits[i] = minChar;
        }
        return new String(digits);
    }
}