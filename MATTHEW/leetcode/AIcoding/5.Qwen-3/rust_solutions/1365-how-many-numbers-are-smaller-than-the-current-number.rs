impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn smaller_numbers_than_current(nums: Vec<i32>) -> Vec<i32> {
        let mut count_map = HashMap::new();
        let sorted_nums = {
            let mut temp = nums.clone();
            temp.sort();
            temp
        };

        for (i, &num) in sorted_nums.iter().enumerate() {
            if !count_map.contains_key(&num) {
                count_map.insert(num, i as i32);
            }
        }

        let mut result = Vec::with_capacity(nums.len());
        for num in nums {
            result.push(*count_map.get(&num).unwrap());
        }

        result
    }
}
}