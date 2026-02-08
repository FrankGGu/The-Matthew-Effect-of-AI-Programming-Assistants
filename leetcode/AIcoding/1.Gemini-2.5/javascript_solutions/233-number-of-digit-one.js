var countDigitOne = function(n) {
    let count = 0;
    let k = 1; // Current place value (1, 10, 100, ...)

    while (k <= n) {
        // Calculate the number of full blocks of 10*k numbers
        // For example, if k=1 (units place), divisor=10.
        // n=13: Math.floor(13 / 10) = 1. This means one full block of 0-9.
        // In this block, '1' appears once (at 1). So add 1*k.
        // For k=10 (tens place), divisor=100.
        // n=13: Math.floor(13 / 100) = 0. No full block of 0-99.
        count += Math.floor(n / (k * 10)) * k;

        // Calculate the remainder part
        // For example, if k=1 (units place), remainder=13%10=3.
        // For k=10 (tens place), remainder=13%100=13.
        let remainder = n % (k * 10);

        // If the remainder is large enough to include the '1's in the current block
        // For k=1, if remainder >= 2 (e.g., 3), it means we passed '1' in the units place.
        // So we add 'k' ones (for 1, 11, 21, ...).
        // Example n=13, k=1: remainder=3. 3 >= 2*1. Add 1. (from 1)
        // Example n=20, k=10: remainder=20. 20 >= 2*10. Add 10. (from 10, 11, ..., 19)
        if (remainder >= 2 * k) {
            count += k;
        }
        // If the remainder is in the range where '1' appears at the current digit
        // For k=1, if remainder is 1 (e.g., n=1), add 1.
        // For k=10, if remainder is 10-19 (e.g., n=13, remainder=13), add (remainder - k + 1) ones.
        // Example n=13, k=10: remainder=13. 13 >= 10. Add (13 - 10 + 1) = 4. (from 10, 11, 12, 13)
        else if (remainder >= k) {
            count += remainder - k + 1;
        }

        // Move to the next place value
        k *= 10;
    }

    return count;
};