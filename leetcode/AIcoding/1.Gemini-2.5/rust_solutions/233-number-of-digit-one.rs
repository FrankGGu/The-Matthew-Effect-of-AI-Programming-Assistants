impl Solution {
    pub fn count_digit_one(n: i32) -> i32 {
        let mut total_ones: i32 = 0;
        let mut k: i64 = 1; // Represents the current digit place value (1, 10, 100, ...)

        // Iterate through each digit position
        // k will eventually exceed n, at which point there are no more significant digits
        while k <= n as i64 {
            // high: The number formed by digits more significant than the current digit position
            let high = (n as i64) / (k * 10);
            // current_digit: The digit at the current position k
            let current_digit = ((n as i64) / k) % 10;
            // low: The number formed by digits less significant than the current digit position
            let low = (n as i64) % k;

            if current_digit == 0 {
                // If the current digit is 0, the number of 1s at this position is determined
                // by the higher part. E.g., for n=209, k=10 (tens place), high=2, current_digit=0.
                // Numbers are 10-19, 110-119. Count = high * k = 2 * 10 = 20.
                total_ones += (high * k) as i32;
            } else if current_digit == 1 {
                // If the current digit is 1, the number of 1s at this position is determined
                // by the higher part, plus the lower part, plus 1 (for the current number itself).
                // E.g., for n=219, k=10, high=2, current_digit=1, low=9.
                // Numbers are 10-19, 110-119 (from high*k), plus 210-219 (from low+1).
                // Count = high * k + low + 1 = 2 * 10 + 9 + 1 = 30.
                total_ones += (high * k + low + 1) as i32;
            } else { // current_digit > 1
                // If the current digit is greater than 1, the number of 1s at this position
                // is determined by the higher part plus an additional k (for the full range 0-k-1).
                // E.g., for n=229, k=10, high=2, current_digit=2.
                // Numbers are 10-19, 110-119, 210-219. Count = (high + 1) * k = (2 + 1) * 10 = 30.
                total_ones += ((high + 1) * k) as i32;
            }

            // Move to the next digit position (tens, hundreds, thousands, etc.)
            // k is i64 to prevent overflow when calculating k * 10, as n can be up to 2 * 10^9.
            // k will not overflow i64, as i64::MAX is much larger than 10^10.
            k *= 10;
        }

        total_ones
    }
}