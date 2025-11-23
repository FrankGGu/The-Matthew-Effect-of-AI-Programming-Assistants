class Solution {
    public long makeIntegerBeautiful(long n, int target) {
        long original_n = n;
        long current_n = n;
        long x = 0;
        long power_of_10 = 1;

        while (sumDigits(current_n) > target) {
            long remainder = current_n % (power_of_10 * 10);

            if (remainder == 0) {
                // current_n is already a multiple of (power_of_10 * 10)
                // We need to move to the next higher power of 10
                power_of_10 *= 10;
                continue; 
            }

            long needed_addition = (power_of_10 * 10) - remainder;
            current_n += needed_addition;
            x += needed_addition;

            power_of_10 *= 10;
        }

        return x;
    }

    private long sumDigits(long num) {
        long sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}