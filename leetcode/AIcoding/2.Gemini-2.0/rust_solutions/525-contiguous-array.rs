use std::collections::HashMap;

impl Solution {
    pub fn find_max_length(nums: Vec<i32>) -> i32 {
        let mut max_len = 0;
        let mut count = 0;
        let mut count_map: HashMap<i32, usize> = HashMap::new();
        count_map.insert(0, 0);

        for i in 0..nums.len() {
            if nums[i] == 0 {
                count -= 1;
            } else {
                count += 1;
            }

            if count_map.contains_key(&count) {
                let prev_index = count_map.get(&count).unwrap();
                max_len = max_len.max((i + 1 - prev_index) as i32);
            } else {
                count_map.insert(count, i + 1);
            }
        }

        max_len
    }
}