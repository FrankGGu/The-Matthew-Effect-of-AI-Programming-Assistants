class Solution {
    public int countDigitOne(int n) {
        int count = 0;
        long k = 1; // Current place value (1, 10, 100, ...)

        while (k <= n) {
            long divider = k * 10;
            long high = n / divider;
            long current = (n % divider) / k;
            long low = n % k;

            if (current == 0) {
                count += high * k;
            } else if (current == 1) {
                count += high * k + low + 1;
            } else { // current > 1
                count += (high + 1) * k;
            }

            // This condition is to prevent k from overflowing if n is very large,
            // though k as long already handles up to 10^18.
            // For n up to Integer.MAX_VALUE, k will go up to 10^9.
            // k * 10 would be 10^10, which fits in long.
            // The loop condition `k <= n` will eventually become false.
            if (k > n / 10 && k < Integer.MAX_VALUE) { // Added k < Integer.MAX_VALUE to handle cases where n/10 is 0 for small n
                break;
            }
            k *= 10;
        }
        return count;
    }
}