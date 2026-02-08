use std::collections::HashMap;

impl Solution {
    pub fn find_max_length(nums: Vec<i32>) -> i32 {
        let mut max_len = 0;
        let mut count = 0;
        let mut map: HashMap<i32, i32> = HashMap::new();
        map.insert(0, -1);

        for i in 0..nums.len() {
            if nums[i] == 0 {
                count -= 1;
            } else {
                count += 1;
            }

            if map.contains_key(&count) {
                max_len = max_len.max(i as i32 - map.get(&count).unwrap());
            } else {
                map.insert(count, i as i32);
            }
        }

        max_len
    }
}