impl Solution {
    pub fn minimize_or(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k_usize = k as usize;

        // Helper function to check if it's possible to achieve an OR sum
        // where all remaining elements 'x' satisfy (x | target_or_value) == target_or_value.
        // This means no remaining element has a bit set that is not set in target_or_value.
        // It returns true if we can achieve this with at most k operations.
        let check = |target_or_value: u32| -> bool {
            let mut num_segments = 0;
            // current_and_val stores the bitwise AND of the current contiguous segment.
            // Initialized to u32::MAX (all bits set) so that the first AND operation
            // with a number effectively initializes it to that number.
            let mut current_and_val = u32::MAX; 

            for &num_i32 in nums.iter() {
                let num = num_i32 as u32;
                if current_and_val == u32::MAX { // Start of a new segment
                    current_and_val = num;
                } else { // Continue current segment by ANDing with the next number
                    current_and_val &= num;
                }

                // If the current segment's AND value (current_and_val) satisfies the
                // target_or_value condition, it means all bits set in current_and_val
                // are also set in target_or_value. This segment can be a valid final element.
                // To maximize the number of final elements (and thus minimize operations),
                // we greedily "close" this segment and start a new one.
                if (current_and_val | target_or_value) == target_or_value {
                    num_segments += 1;
                    current_and_val = u32::MAX; // Reset to start a new segment
                }
            }

            // The total number of operations used is (n - num_segments).
            // We need to check if (n - num_segments) <= k.
            // This is equivalent to num_segments >= n - k.
            num_segments >= (n - k_usize)
        };

        let mut low = 0;
        // The maximum possible value for an element is 10^9.
        // 10^9 is less than 2^30 (1,073,741,824).
        // So, an OR sum will not exceed (1 << 30) - 1.
        let mut high = (1 << 30) - 1; 
        let mut ans = high;

        // Binary search for the minimum possible OR sum.
        while low <= high {
            let mid = low + (high - low) / 2;
            if check(mid) {
                // If 'mid' OR sum is achievable, try for a smaller one.
                ans = mid;
                high = mid - 1;
            } else {
                // If 'mid' OR sum is not achievable, we need a larger one.
                low = mid + 1;
            }
        }

        ans as i32
    }
}