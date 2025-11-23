class Solution {
public:
    int countDigitOne(int n) {
        if (n < 0) {
            return 0;
        }

        long long count = 0;
        long long i = 1; // Represents the current place value (1, 10, 100, ...)

        while (i <= n) {
            long long divisor = i * 10;
            long long quotient = n / divisor;
            long long remainder = n % divisor;

            // Count ones in the full blocks of 'divisor' numbers
            // Each full block (e.g., 0-99 for i=10) has 'i' ones at the current place.
            count += quotient * i;

            // Count ones in the current partial block (from the start of the current block up to n)
            long long digit = remainder / i; // The digit at the current place 'i'
            long long rem_after_digit = remainder % i; // The part of the remainder after the current digit

            if (digit == 1) {
                // If the digit at the current place is 1, then all numbers from
                // X10...0 to X1(rem_after_digit) have a '1' at this position.
                // This accounts for 'rem_after_digit + 1' occurrences.
                count += rem_after_digit + 1;
            } else if (digit > 1) {
                // If the digit at the current place is greater than 1, it means
                // the full range of numbers with '1' at this position (e.g., X10...0 to X19...9)
                // has been covered in the current partial block.
                // This accounts for 'i' occurrences.
                count += i;
            }

            // Move to the next place value.
            // Check for potential overflow of i * 10 if i is very large,
            // though with i as long long and n as int, this is less critical
            // as i will exceed n before overflowing long long.
            if (i > n / 10 && i <= n) { // i * 10 would exceed n, so no more full place values to check within n.
                break;
            }
            i *= 10;
        }

        return count;
    }
};