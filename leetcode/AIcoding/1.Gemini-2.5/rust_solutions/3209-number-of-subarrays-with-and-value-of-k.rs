use std::collections::HashMap;

impl Solution {
    pub fn subarrays_with_and_value_of_k(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut total_count: i64 = 0;
        let mut map_prev: HashMap<i32, i64> = HashMap::new();

        for i in 0..n {
            let mut map_curr: HashMap<i32, i64> = HashMap::new();

            // Subarray [i, i]
            *map_curr.entry(nums[i]).or_insert(0) += 1;

            // Extend subarrays ending at i-1
            for (&and_val, &count) in map_prev.iter() {
                let new_and_val = and_val & nums[i];
                *map_curr.entry(new_and_val).or_insert(0) += count;
            }

            // Add counts for current index i
            for (&and_val, &count) in map_curr.iter() {
                if and_val == k {
                    total_count += count;
                }
            }

            // Update map_prev for the next iteration
            map_prev = map_curr;
        }

        total_count
    }
}