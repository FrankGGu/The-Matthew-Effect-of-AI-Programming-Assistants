class Solution {
    public int smallestDivisibleDigitProduct(int n) {
        for (int i = 1; ; i++) {
            if (i % n == 0 && digitProduct(i) == n) {
                return i;
            }
        }
    }

    private int digitProduct(int num) {
        int product = 1;
        while (num > 0) {
            int digit = num % 10;
            if (digit == 0) {
                return 0;
            }
            product *= digit;
            num /= 10;
        }
        return product;
    }
}