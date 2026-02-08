public class Solution {
    public int maximumSwap(int num) {
        char[] digits = String.valueOf(num).toCharArray();
        int[] lastIndices = new int[10];

        for (int i = 0; i < digits.length; i++) {
            lastIndices[digits[i] - '0'] = i;
        }

        for (int i = 0; i < digits.length; i++) {
            int currentDigit = digits[i] - '0';
            for (int d = 9; d > currentDigit; d--) {
                if (lastIndices[d] > i) {
                    char temp = digits[i];
                    digits[i] = digits[lastIndices[d]];
                    digits[lastIndices[d]] = temp;
                    return Integer.parseInt(new String(digits));
                }
            }
        }

        return num;
    }
}