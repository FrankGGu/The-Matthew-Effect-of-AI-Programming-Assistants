use std::collections::HashMap;

impl Solution {
    pub fn check_subarray_sum(nums: Vec<i32>, k: i32) -> bool {
        let mut map: HashMap<i64, i32> = HashMap::new();
        map.insert(0, -1);

        let mut current_sum: i64 = 0;

        for i in 0..nums.len() {
            current_sum += nums[i] as i64;

            let key_to_check = if k == 0 {
                current_sum
            } else {
                let k_i64 = k as i64;
                (current_sum % k_i64 + k_i64) % k_i64
            };

            if let Some(&prev_index) = map.get(&key_to_check) {
                if (i as i32) - prev_index >= 2 {
                    return true;
                }
            } else {
                map.insert(key_to_check, i as i32);
            }
        }

        false
    }
}