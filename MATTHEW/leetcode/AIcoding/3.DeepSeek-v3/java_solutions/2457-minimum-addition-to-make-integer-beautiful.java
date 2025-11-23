class Solution {
    public long makeIntegerBeautiful(long n, int target) {
        long original = n;
        long base = 1;
        while (sumDigits(n) > target) {
            n = n / 10 + 1;
            base *= 10;
        }
        return n * base - original;
    }

    private int sumDigits(long num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}