impl Solution {
    pub fn shortest_subarray_with_or_at_least_k(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut min_len = usize::MAX;
        let mut l = 0;
        let mut bit_counts = vec![0; 30]; // Numbers up to 10^9 fit within 30 bits (0-29)

        for r in 0..n {
            // Add nums[r] to the window
            for i in 0..30 {
                if ((nums[r] >> i) & 1) == 1 {
                    bit_counts[i] += 1;
                }
            }

            // Calculate current_or from bit_counts
            let mut current_or = 0;
            for i in 0..30 {
                if bit_counts[i] > 0 {
                    current_or |= (1 << i);
                }
            }

            // Shrink the window from the left while current_or >= k
            while current_or >= k {
                min_len = min_len.min(r - l + 1);

                // Remove nums[l] from the window
                for i in 0..30 {
                    if ((nums[l] >> i) & 1) == 1 {
                        bit_counts[i] -= 1;
                    }
                }
                l += 1;

                // Recalculate current_or after removing nums[l]
                current_or = 0;
                for i in 0..30 {
                    if bit_counts[i] > 0 {
                        current_or |= (1 << i);
                    }
                }
            }
        }

        if min_len == usize::MAX {
            -1
        } else {
            min_len as i32
        }
    }
}