use std::collections::HashMap;

impl Solution {
    pub fn find_max_length(nums: Vec<i32>) -> i32 {
        let mut map: HashMap<i32, i32> = HashMap::new();
        map.insert(0, -1);
        let mut sum = 0;
        let mut max_len = 0;

        for i in 0..nums.len() {
            if nums[i] == 0 {
                sum -= 1;
            } else {
                sum += 1;
            }

            if let Some(&prev_idx) = map.get(&sum) {
                max_len = max_len.max(i as i32 - prev_idx);
            } else {
                map.insert(sum, i as i32);
            }
        }
        max_len
    }
}