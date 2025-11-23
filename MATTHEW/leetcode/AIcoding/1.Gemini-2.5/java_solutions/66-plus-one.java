class Solution {
    public int[] plusOne(int[] digits) {
        int n = digits.length;

        for (int i = n - 1; i >= 0; i--) {
            if (digits[i] < 9) {
                digits[i]++;
                return digits;
            }
            digits[i] = 0;
        }

        // If we reach here, it means all digits were 9 (e.g., [9,9,9])
        // We need a new array with an additional leading 1
        int[] newDigits = new int[n + 1];
        newDigits[0] = 1;
        // The rest of the elements are already 0 by default
        return newDigits;
    }
}