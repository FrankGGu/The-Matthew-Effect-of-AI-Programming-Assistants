impl Solution {
    pub fn consecutive_numbers_sum(n: i32) -> i32 {
        let mut count = 0;
        let n_long = n as i64;

        // The sum of k consecutive positive integers starting from x is:
        // n = x + (x+1) + ... + (x+k-1)
        // Using the formula for an arithmetic series: n = k * (first_term + last_term) / 2
        // n = k * (x + x + k - 1) / 2
        // 2n = k * (2x + k - 1)

        // Let k be the number of terms.
        // We need x >= 1, which implies 2x >= 2.
        // So, (2x + k - 1) >= (2 + k - 1) = k + 1.
        // From 2n = k * (2x + k - 1), we must have 2n/k >= k + 1.
        // This implies k * (k + 1) <= 2n.
        // This inequality gives an upper bound for k.
        // k^2 + k - 2n <= 0.
        // Using the quadratic formula for roots of k^2 + k - 2n = 0: k = (-1 +/- sqrt(1 - 4*1*(-2n))) / 2 = (-1 +/- sqrt(1 + 8n)) / 2.
        // Since k must be positive, k <= (-1 + sqrt(1 + 8n)) / 2.

        // Also, for x to be an integer, 2x must be an even integer.
        // From 2x = (2n/k) - k + 1, we need (2n/k) - k + 1 to be even.
        // Since we already established (2n/k) >= k+1, it means (2n/k) - k + 1 >= 2, so it's always positive.
        // The condition (2n/k) - k + 1 being even is equivalent to (2n/k) - k being odd.
        // This means (2n/k) and k must have different parities.

        // Calculate the upper limit for k.
        // n can be up to 10^9, so 1 + 8*n can be up to 1 + 8*10^9, which requires i64 for calculation to avoid overflow.
        let limit_f64 = ((-1.0 + (1.0 + 8.0 * n_long as f64).sqrt()) / 2.0).floor();
        let limit = limit_f64 as i64;

        // Iterate k from 1 up to the calculated limit.
        for k in 1..=limit {
            // Check if 2n is divisible by k.
            if (2 * n_long) % k == 0 {
                let val = (2 * n_long) / k; // This is (2x + k - 1)

                // Check if val and k have different parities.
                // This is equivalent to (val - k) % 2 != 0, or (val - k + 1) % 2 == 0.
                if (val - k + 1) % 2 == 0 {
                    count += 1;
                }
            }
        }

        count
    }
}