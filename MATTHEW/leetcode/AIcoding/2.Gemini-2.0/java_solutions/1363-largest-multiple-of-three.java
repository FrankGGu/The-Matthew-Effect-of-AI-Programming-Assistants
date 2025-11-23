import java.util.Arrays;

class Solution {
    public String largestMultipleOfThree(int[] digits) {
        int sum = 0;
        int[] remainder1 = new int[0];
        int[] remainder2 = new int[0];

        for (int digit : digits) {
            sum += digit;
            if (digit % 3 == 1) {
                remainder1 = append(remainder1, digit);
            } else if (digit % 3 == 2) {
                remainder2 = append(remainder2, digit);
            }
        }

        Arrays.sort(remainder1);
        Arrays.sort(remainder2);

        if (sum % 3 == 1) {
            if (remainder1.length >= 1) {
                remove(digits, remainder1[0]);
            } else if (remainder2.length >= 2) {
                remove(digits, remainder2[0]);
                remove(digits, remainder2[1]);
            } else {
                return "0";
            }
        } else if (sum % 3 == 2) {
            if (remainder2.length >= 1) {
                remove(digits, remainder2[0]);
            } else if (remainder1.length >= 2) {
                remove(digits, remainder1[0]);
                remove(digits, remainder1[1]);
            } else {
                return "0";
            }
        }

        Arrays.sort(digits);
        StringBuilder sb = new StringBuilder();
        for (int i = digits.length - 1; i >= 0; i--) {
            sb.append(digits[i]);
        }

        String result = sb.toString();
        if (result.length() > 0 && result.charAt(0) == '0') {
            int i = 0;
            while (i < result.length() - 1 && result.charAt(i) == '0') {
                i++;
            }
            return result.substring(i);
        }

        return result.length() == 0 ? "0" : result;
    }

    private int[] append(int[] arr, int num) {
        int[] newArr = new int[arr.length + 1];
        System.arraycopy(arr, 0, newArr, 0, arr.length);
        newArr[arr.length] = num;
        return newArr;
    }

    private void remove(int[] digits, int num) {
        for (int i = 0; i < digits.length; i++) {
            if (digits[i] == num) {
                digits[i] = -1;
                return;
            }
        }
    }
}