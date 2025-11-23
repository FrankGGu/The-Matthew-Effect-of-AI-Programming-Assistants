#include <limits.h> // For INT_MAX, INT_MIN

int divide(int dividend, int divisor) {
    // Handle overflow case: INT_MIN / -1
    // The result of INT_MIN / -1 is 2147483648, which is INT_MAX + 1.
    // The problem statement requires returning INT_MAX in this scenario.
    if (dividend == INT_MIN && divisor == -1) {
        return INT_MAX;
    }

    // Determine the sign of the result.
    // If dividend and divisor have different signs, the result is negative.
    // Otherwise, the result is positive.
    int is_negative = 0;
    if ((dividend < 0 && divisor > 0) || (dividend > 0 && divisor < 0)) {
        is_negative = 1;
    }

    // Convert both dividend and divisor to negative numbers.
    // This approach helps handle INT_MIN gracefully, as abs(INT_MIN) overflows
    // (INT_MIN has no positive counterpart in a 32-bit signed integer).
    // By working with negative numbers, INT_MIN remains INT_MIN.
    int d = dividend;
    int s = divisor;

    if (d > 0) d = -d;
    if (s > 0) s = -s;

    long long quotient = 0; // Use long long to prevent overflow during accumulation of quotient parts.

    // Main loop: repeatedly subtract divisor from dividend.
    // Both 'd' (current dividend) and 's' (divisor) are negative.
    // The condition 'd <= s' means 'd' is "more negative" or equal to 's'.
    while (d <= s) {
        int current_divisor_multiple = s; // Start with the divisor 's'
        int multiple = 1;                 // Represents the power of 2 (2^k) for current_divisor_multiple

        // Inner loop: Find the largest multiple of 's' (by powers of 2)
        // that is still "greater than or equal to" 'd'.
        // We double 'current_divisor_multiple' as long as two conditions are met:
        // 1. 'current_divisor_multiple' can be doubled without overflowing to a positive value.
        //    This check: `current_divisor_multiple >= (INT_MIN >> 1)` ensures that `current_divisor_multiple << 1`
        //    will not wrap around to a positive number. (e.g., if current_divisor_multiple is 0xA0000000, <<1 is 0x40000000 (positive)).
        //    If current_divisor_multiple is INT_MIN / 2 (0xC0000000), then <<1 is INT_MIN (0x80000000), which is fine.
        // 2. 'current_divisor_multiple * 2' is still "greater than or equal to" 'd'.
        //    This check: `(current_divisor_multiple << 1) >= d` ensures we don't overshoot 'd'.
        // 3. 'multiple' can be doubled without overflowing to a negative value.
        //    This check: `(multiple << 1) > 0` prevents 'multiple' from becoming INT_MIN (0x80000000) if it reaches 1 << 31.
        while (current_divisor_multiple >= (INT_MIN >> 1) &&
               (current_divisor_multiple << 1) >= d &&
               (multiple << 1) > 0) {
            current_divisor_multiple <<= 1;
            multiple <<= 1;
        }

        d -= current_divisor_multiple; // Subtract the largest found multiple from the dividend
        quotient += multiple;         // Add its corresponding power of 2 to the total quotient
    }

    // Apply the determined sign to the final quotient.
    if (is_negative) {
        return (int)-quotient;
    } else {
        // If the result is positive, check for overflow against INT_MAX.
        // This can happen if the calculated quotient (e.g., 2^31 for INT_MAX/1)
        // exceeds INT_MAX (2^31 - 1).
        if (quotient > INT_MAX) {
            return INT_MAX;
        }
        return (int)quotient;
    }
}