struct Solution;

impl Solution {
    pub fn num_subarrays_with_odd_sum(arr: Vec<i32>) -> i32 {
        let mut odd_prefix_sums_count = 0;
        let mut even_prefix_sums_count = 1; // Represents the initial prefix sum of 0 (before any elements)
        let mut current_prefix_sum_parity = 0; // 0 for even, 1 for odd
        let mut total_odd_subarrays = 0;
        let modulus = 1_000_000_007;

        for num in arr {
            // Update the parity of the current prefix sum
            // (current_prefix_sum_parity + num_parity) % 2
            // For positive numbers, num % 2 is 0 or 1.
            current_prefix_sum_parity = (current_prefix_sum_parity + (num % 2)) % 2;

            if current_prefix_sum_parity == 1 { // Current prefix sum is odd
                // To get an odd subarray sum (S[k] - S[j-1]), if S[k] is odd, S[j-1] must be even.
                // We add the count of even prefix sums encountered so far.
                total_odd_subarrays = (total_odd_subarrays + even_prefix_sums_count) % modulus;
                odd_prefix_sums_count += 1;
            } else { // Current prefix sum is even
                // To get an odd subarray sum (S[k] - S[j-1]), if S[k] is even, S[j-1] must be odd.
                // We add the count of odd prefix sums encountered so far.
                total_odd_subarrays = (total_odd_subarrays + odd_prefix_sums_count) % modulus;
                even_prefix_sums_count += 1;
            }
        }

        total_odd_subarrays
    }
}