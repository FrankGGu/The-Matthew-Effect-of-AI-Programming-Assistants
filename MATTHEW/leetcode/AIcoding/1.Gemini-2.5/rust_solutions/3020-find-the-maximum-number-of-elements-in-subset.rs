use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn find_maximum_number_of_elements_in_subset(nums: Vec<i32>) -> i32 {
        let mut counts: HashMap<i64, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num as i64).or_insert(0) += 1;
        }

        let mut ans = 0;

        // Handle the special case of '1'
        if counts.contains_key(&1) {
            // '1' can always be part of the subset. Its square is 1, which is itself.
            // If '1' is present, it contributes 1 to the total count.
            ans = 1;
            // Remove '1' from the map so it's not processed as part of other chains
            // and doesn't interfere with the chain finding logic.
            counts.remove(&1); 
        }

        // Collect keys to iterate over, as we will be modifying the map during iteration.
        let keys: Vec<i64> = counts.keys().cloned().collect();

        // Iterate through the remaining numbers to find and sum up lengths of disjoint chains
        for num in keys {
            // If 'num' is still in the map, it means it hasn't been consumed by a previous chain
            // (e.g., 4 would be consumed if 2 was processed first).
            if counts.contains_key(&num) { 
                let mut current_chain_len = 0;
                let mut curr = num;

                // Build a chain: curr, curr^2, curr^4, ...
                while counts.contains_key(&curr) {
                    current_chain_len += 1;
                    counts.remove(&curr); // Mark as used by removing from map

                    // Check for potential overflow and if curr*curr would exceed 10^9.
                    // The maximum value for an element in nums is 10^9.
                    // If curr > sqrt(10^9) approx 31622.77, then curr*curr will be > 10^9.
                    // In such a case, curr*curr cannot be in 'nums', so the chain effectively ends here
                    // according to the problem's implicit interpretation.
                    if curr > 31622 { 
                        break;
                    }
                    curr *= curr;
                }
                ans += current_chain_len;
            }
        }

        ans
    }
}