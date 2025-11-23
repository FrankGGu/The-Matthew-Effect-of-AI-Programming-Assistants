use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn min_array_changes(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        if n <= 2 {
            return 0;
        }

        let mut max_len = 1; // At least one element can always form an arithmetic progression of length 1.

        // Iterate through each element nums[i] as a potential starting point of an arithmetic progression.
        for i in 0..n {
            // HashMap to store counts of (k, b_0) pairs for arithmetic progressions that include nums[i].
            // Key: (k, b_0) - (common difference, first term)
            // Value: count of elements found so far (excluding nums[i]) that form an AP with nums[i]
            let mut counts_for_i: HashMap<(i64, i64), i32> = HashMap::new();

            // Iterate through elements nums[j] after nums[i]
            for j in (i + 1)..n {
                let diff = (nums[j] - nums[i]) as i64;
                let idx_diff = (j - i) as i64;

                // If (nums[j] - nums[i]) is divisible by (j - i), then k is an integer.
                if diff % idx_diff == 0 {
                    let k = diff / idx_diff;
                    // Calculate the first term b_0 = nums[i] - i * k
                    let b_0 = nums[i] as i64 - (i as i64) * k;

                    // Increment the count for this (k, b_0) pair
                    let count = counts_for_i.entry((k, b_0)).or_insert(0);
                    *count += 1;

                    // Update max_len. The current `*count` is the number of elements
                    // (excluding nums[i]) that form this AP. Add 1 for nums[i] itself.
                    max_len = max(max_len, *count + 1);
                }
            }
        }

        (n as i32 - max_len)
    }
}