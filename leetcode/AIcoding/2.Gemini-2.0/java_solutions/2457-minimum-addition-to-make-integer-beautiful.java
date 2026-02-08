class Solution {
    public long makeIntegerBeautiful(long n, int target) {
        long num = n;
        long powerOfTen = 1;
        while (sumOfDigits(num) > target) {
            long remainder = num % 10;
            num = num / 10 + 1;
            long addition = powerOfTen * (10 - remainder);
            n += addition;
            powerOfTen *= 10;
        }
        return n - num * powerOfTen /10 + num * powerOfTen / 10 - (n - num * powerOfTen /10);
    }

    private int sumOfDigits(long n) {
        int sum = 0;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return sum;
    }
}