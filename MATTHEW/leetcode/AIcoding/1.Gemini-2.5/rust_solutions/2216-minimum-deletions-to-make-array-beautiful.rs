struct Solution;

impl Solution {
    pub fn min_deletions(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut kept_count = 0;
        let mut last_kept_val = 0; // Sentinel value, actual value will be set when kept_count is even

        for i in 0..n {
            if kept_count % 2 == 0 {
                // We are looking to fill an even index (0, 2, 4, ...).
                // This is the first element of a pair. We can always keep it.
                last_kept_val = nums[i];
                kept_count += 1;
            } else {
                // We are looking to fill an odd index (1, 3, 5, ...).
                // This is the second element of a pair. It must be different from the last kept value.
                if nums[i] != last_kept_val {
                    kept_count += 1;
                }
            }
        }

        // If the total number of elements kept is odd, we must delete one more
        // to satisfy the "even length" condition for a beautiful array.
        let final_kept_len = if kept_count % 2 == 0 {
            kept_count
        } else {
            kept_count - 1
        };

        (n - final_kept_len) as i32
    }
}