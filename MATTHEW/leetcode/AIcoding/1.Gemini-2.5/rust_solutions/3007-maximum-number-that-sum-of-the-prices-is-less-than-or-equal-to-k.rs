impl Solution {
    pub fn find_maximum_number(k: i64) -> i64 {
        // Function to calculate the sum of popcounts (number of set bits) for all integers
        // from 1 to n. P(n) = sum(popcount(i) for i in 1 to n).
        // This is equivalent to sum(popcount(i) for i in 0 to n) because popcount(0) is 0.
        // The calculation iterates through each bit position `j` (0-indexed) and counts
        // how many numbers in the range [1, n] have the `j`-th bit set.
        fn calculate_sum_popcounts(n: i64) -> i64 {
            if n == 0 {
                return 0;
            }
            let mut total_set_bits = 0;
            // Iterate through bit positions. Since n can be up to 2 * 10^15 (approx 2^51),
            // we need to check up to bit position 60 (as 2^60 is approx 10^18).
            for j in 0..61 {
                let block_size = 1i64 << (j + 1); // Size of a complete block (e.g., for j=0, block_size=2; for j=1, block_size=4)
                let half_block_size = 1i64 << j; // Number of elements in a block where j-th bit is set

                // Count contributions from full blocks within [0, n]
                let num_full_blocks = n / block_size;
                total_set_bits += num_full_blocks * half_block_size;

                // Count contributions from the remaining partial block
                let remainder = n % block_size;
                // If the remainder is large enough to include numbers where the j-th bit is set
                // (i.e., numbers from `half_block_size` up to `remainder` within the current block)
                total_set_bits += (remainder - half_block_size + 1).max(0);
            }
            total_set_bits
        }

        let mut low = 0;
        // A sufficiently large upper bound for binary search.
        // If k is 10^15, x is likely in the range of 10^13 to 10^14.
        // 2 * 10^15 (approx 2^51) is a safe upper bound.
        let mut high = 2_000_000_000_000_000i64; // 2 * 10^15
        let mut ans = 0;

        // Binary search for the maximum x such that P(x) <= k
        while low <= high {
            let mid = low + (high - low) / 2;

            // Calculate P(mid)
            let sum_prices = calculate_sum_popcounts(mid);

            if sum_prices <= k {
                // mid is a possible answer, try for a larger x
                ans = mid;
                low = mid + 1;
            } else {
                // mid is too large, search in the lower half
                high = mid - 1;
            }
        }
        ans
    }
}