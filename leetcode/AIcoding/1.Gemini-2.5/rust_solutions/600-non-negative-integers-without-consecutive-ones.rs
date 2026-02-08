struct Solution;

impl Solution {
    pub fn find_integers(n: i32) -> i32 {
        // fib[i] stores the count of binary strings of length i without consecutive ones.
        // fib[0] = 1 (empty string)
        // fib[1] = 2 ("0", "1")
        // fib[i] = fib[i-1] + fib[i-2] for i >= 2
        // Max n is 10^9, which is less than 2^30. So we need up to fib[30].
        let mut fib = vec![0; 32];
        fib[0] = 1;
        fib[1] = 2;
        for i in 2..32 {
            fib[i] = fib[i - 1] + fib[i - 2];
        }

        let mut ans = 0;
        let mut prev_bit_was_one = false;

        // Iterate from the most significant bit (MSB) down to the least significant bit (LSB).
        // For i32, the highest possible bit index is 30 (for 2^30).
        // The loop goes from 30 down to 0.
        for i in (0..31).rev() {
            if (n >> i) & 1 == 1 { // If the i-th bit of n is 1
                // Add all valid numbers that are smaller than n at this bit position.
                // These numbers have a 0 at this bit position, and any valid suffix of length i.
                ans += fib[i];

                // If the previous bit was also 1, then n contains "11".
                // This means n itself is not a valid number.
                // Also, any number formed by keeping the prefix and setting this bit to 1
                // would also contain "11" and thus be invalid.
                // So, we cannot form any more valid numbers by continuing with this prefix.
                // We return the current count.
                if prev_bit_was_one {
                    return ans;
                }
                // Mark that the current bit was 1.
                prev_bit_was_one = true;
            } else { // If the i-th bit of n is 0
                // Reset the flag as there is no consecutive one.
                prev_bit_was_one = false;
            }
        }

        // If the loop completes without returning, it means n itself does not contain
        // consecutive ones and is a valid number. We need to include n in the count.
        ans + 1
    }
}