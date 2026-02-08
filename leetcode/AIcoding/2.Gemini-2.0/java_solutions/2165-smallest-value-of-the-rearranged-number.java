import java.util.Arrays;

class Solution {
    public long smallestNumber(long num) {
        if (num == 0) {
            return 0;
        }

        boolean isNegative = num < 0;
        num = Math.abs(num);

        char[] digits = String.valueOf(num).toCharArray();
        Arrays.sort(digits);

        if (isNegative) {
            reverse(digits);
            return -Long.parseLong(new String(digits));
        } else {
            int firstNonZero = 0;
            while (firstNonZero < digits.length && digits[firstNonZero] == '0') {
                firstNonZero++;
            }

            if (firstNonZero < digits.length) {
                char temp = digits[0];
                digits[0] = digits[firstNonZero];
                digits[firstNonZero] = temp;
            }

            return Long.parseLong(new String(digits));
        }
    }

    private void reverse(char[] arr) {
        int left = 0;
        int right = arr.length - 1;
        while (left < right) {
            char temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }
    }
}