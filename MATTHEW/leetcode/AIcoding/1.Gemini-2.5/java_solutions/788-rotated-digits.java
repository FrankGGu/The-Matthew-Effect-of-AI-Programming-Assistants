class Solution {
    public int rotatedDigits(int n) {
        int count = 0;
        for (int i = 1; i <= n; i++) {
            boolean isValid = true;
            boolean isRotatedDifferent = false;
            int num = i;
            while (num > 0) {
                int digit = num % 10;
                if (digit == 3 || digit == 4 || digit == 6 || digit == 7 || digit == 9) {
                    isValid = false;
                    break;
                }
                if (digit == 2 || digit == 5) {
                    isRotatedDifferent = true;
                }
                num /= 10;
            }
            if (isValid && isRotatedDifferent) {
                count++;
            }
        }
        return count;
    }
}