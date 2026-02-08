class Solution {
    public int rotatedDigits(int N) {
        int count = 0;
        for (int i = 1; i <= N; i++) {
            if (isValid(i)) {
                count++;
            }
        }
        return count;
    }

    private boolean isValid(int num) {
        boolean validFound = false;
        while (num > 0) {
            int digit = num % 10;
            if (digit == 3 || digit == 4 || digit == 7) {
                return false;
            }
            if (digit == 2 || digit == 5 || digit == 6 || digit == 9) {
                validFound = true;
            }
            num /= 10;
        }
        return validFound;
    }
}