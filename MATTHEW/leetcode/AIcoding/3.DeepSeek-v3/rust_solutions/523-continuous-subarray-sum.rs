use std::collections::HashMap;

impl Solution {
    pub fn check_subarray_sum(nums: Vec<i32>, k: i32) -> bool {
        let mut remainder_map = HashMap::new();
        remainder_map.insert(0, -1);
        let mut sum = 0;

        for (i, &num) in nums.iter().enumerate() {
            sum += num;
            let remainder = if k != 0 { sum % k } else { sum };
            if let Some(&prev_index) = remainder_map.get(&remainder) {
                if i as i32 - prev_index > 1 {
                    return true;
                }
            } else {
                remainder_map.insert(remainder, i as i32);
            }
        }

        false
    }
}