use std::collections::HashMap;

impl Solution {
    pub fn min_subarray_removals(nums: Vec<i32>, p: i32) -> i32 {
        let n = nums.len();

        let mut total_sum_mod_p: i32 = 0;
        for &num in &nums {
            total_sum_mod_p = (total_sum_mod_p + (num % p + p) % p) % p;
        }

        let target_rem = total_sum_mod_p;

        if target_rem == 0 {
            return 0;
        }

        let mut min_len = n as i32;
        let mut current_prefix_rem: i32 = 0;
        let mut map: HashMap<i32, i32> = HashMap::new();
        map.insert(0, -1); // To handle subarrays starting from index 0

        for i in 0..n {
            current_prefix_rem = (current_prefix_rem + (nums[i] % p + p) % p) % p;

            // We need (current_prefix_rem - prev_prefix_rem) % p == target_rem
            // This implies (current_prefix_rem - target_rem + p) % p == prev_prefix_rem
            let required_prev_rem = (current_prefix_rem - target_rem + p) % p;

            if let Some(&prev_idx) = map.get(&required_prev_rem) {
                min_len = min_len.min(i as i32 - prev_idx);
            }
            map.insert(current_prefix_rem, i as i32);
        }

        if min_len == n as i32 {
            -1
        } else {
            min_len
        }
    }
}