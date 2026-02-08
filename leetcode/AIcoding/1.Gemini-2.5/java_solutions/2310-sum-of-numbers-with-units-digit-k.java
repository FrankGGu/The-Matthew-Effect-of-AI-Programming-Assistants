class Solution {
    public int sumOfNumbersWithUnitsDigitK(int num, int k) {
        if (num == 0) {
            return 0;
        }

        if (k == 0) {
            if (num % 10 != 0) {
                return -1;
            } else {
                return num / 10;
            }
        }

        for (int n = 1; n <= 10; n++) {
            if (n * k <= num && (n * k) % 10 == num % 10) {
                return n;
            }
        }

        return -1;
    }
}