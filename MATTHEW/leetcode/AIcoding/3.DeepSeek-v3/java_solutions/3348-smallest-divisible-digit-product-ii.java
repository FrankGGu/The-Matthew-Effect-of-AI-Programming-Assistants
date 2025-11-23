class Solution {
    public int smallestNumber(long n) {
        if (n == 1) return 1;
        for (int i = 1; i <= 1e6; i++) {
            if (getDigitProduct(i) == n) {
                return i;
            }
        }
        return -1;
    }

    private long getDigitProduct(int num) {
        long product = 1;
        while (num > 0) {
            int digit = num % 10;
            if (digit == 0) return 0;
            product *= digit;
            num /= 10;
        }
        return product;
    }
}