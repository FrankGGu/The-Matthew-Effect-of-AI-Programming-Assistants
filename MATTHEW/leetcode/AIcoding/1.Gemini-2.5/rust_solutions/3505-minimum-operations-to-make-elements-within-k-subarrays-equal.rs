impl Solution {
    pub fn min_k_bit_flips(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut total_flips = 0; // Total operations performed
        let mut active_flips_at_current_index = 0; // Number of currently active flips affecting the current index
        let mut flip_starts_at_index = vec![false; n]; // flip_starts_at_index[i] is true if an operation started at index i

        for i in 0..n {
            // A flip operation started at `i - k` no longer affects the current index `i`.
            // So, if such an operation existed, decrement the count of active flips.
            if i >= k && flip_starts_at_index[i - k] {
                active_flips_at_current_index -= 1;
            }

            // Determine the current effective value of nums[i].
            // If `active_flips_at_current_index` is even, nums[i] is its original value.
            // If `active_flips_at_current_index` is odd, nums[i] is flipped from its original value.
            let current_effective_val = nums[i] ^ (active_flips_at_current_index % 2);

            if current_effective_val == 0 {
                // If the current element is 0, we must perform a flip starting at index `i`.
                // Check if a flip of length `k` can be performed starting at `i`.
                if i + k > n {
                    // Cannot perform a flip of length k starting at i because it would go out of bounds.
                    // It's impossible to make this element 1.
                    return -1;
                }

                // Perform the flip:
                total_flips += 1;
                active_flips_at_current_index += 1;
                flip_starts_at_index[i] = true;
            }
        }

        total_flips
    }
}