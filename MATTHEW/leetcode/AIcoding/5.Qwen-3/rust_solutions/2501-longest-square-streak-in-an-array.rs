impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn longest_square_streak(nums: Vec<i32>) -> i32 {
        let mut num_set: HashMap<i32, bool> = HashMap::new();
        for &num in &nums {
            num_set.insert(num, true);
        }

        let mut max_length = 0;
        let mut visited = HashMap::new();

        for &num in &nums {
            if !visited.contains_key(&num) {
                let mut length = 0;
                let mut current = num;
                while num_set.contains_key(&current) {
                    visited.insert(current, true);
                    length += 1;
                    current = current * current;
                }
                max_length = std::cmp::max(max_length, length);
            }
        }

        if max_length >= 2 {
            max_length
        } else {
            -1
        }
    }
}
}