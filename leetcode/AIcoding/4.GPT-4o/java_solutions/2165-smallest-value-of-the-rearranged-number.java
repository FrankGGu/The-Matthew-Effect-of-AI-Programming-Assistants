class Solution {
    public long smallestNumber(long num) {
        if (num == 0) return 0;
        boolean isNegative = num < 0;
        String numStr = Long.toString(Math.abs(num));
        char[] digits = numStr.toCharArray();
        Arrays.sort(digits);
        if (isNegative) {
            StringBuilder result = new StringBuilder(new String(digits));
            return -Long.parseLong(result.reverse().toString());
        } else {
            int i = 0;
            while (i < digits.length && digits[i] == '0') {
                i++;
            }
            if (i == digits.length) return 0;
            char firstNonZero = digits[i];
            StringBuilder result = new StringBuilder();
            result.append(firstNonZero);
            for (int j = 0; j < i; j++) {
                result.append('0');
            }
            for (int j = i + 1; j < digits.length; j++) {
                result.append(digits[j]);
            }
            return Long.parseLong(result.toString());
        }
    }
}