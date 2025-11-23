use std::collections::HashSet;

impl Solution {
    pub fn longest_square_streak(nums: Vec<i32>) -> i32 {
        let set: HashSet<i32> = nums.iter().cloned().collect();
        let mut max_len = 0;

        for &num in &nums {
            let mut current_num = num;
            let mut current_len = 1;

            while set.contains(&(current_num as i64 * current_num as i64 as i32)) {
                current_num = (current_num as i64 * current_num as i64) as i32;
                current_len += 1;
            }

            max_len = max_len.max(current_len);
        }

        if max_len > 1 {
            max_len
        } else {
            -1
        }
    }
}