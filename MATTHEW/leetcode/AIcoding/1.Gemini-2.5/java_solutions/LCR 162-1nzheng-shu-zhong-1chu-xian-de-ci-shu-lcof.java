class Solution {
    public int countDigitOne(int n) {
        if (n < 0) {
            return 0;
        }

        long count = 0;
        long k = 1; // current place value (1, 10, 100, ...)

        while (k <= n) {
            long divisor = k * 10;
            long high = n / divisor; // part before the current digit place
            long current = (n / k) % 10; // the digit at the current place
            long low = n % k; // part after the current digit place

            if (current < 1) { // If the current digit is 0
                count += high * k;
            } else if (current == 1) { // If the current digit is 1
                count += high * k + (low + 1);
            } else { // If the current digit is > 1 (e.g., 2, 3, ...)
                count += (high + 1) * k;
            }

            // Move to the next place value
            // k can reach 10^9 for n = 2*10^9. k*10 can be 10^10, which fits in long.
            k *= 10;
        }
        return (int) count;
    }
}