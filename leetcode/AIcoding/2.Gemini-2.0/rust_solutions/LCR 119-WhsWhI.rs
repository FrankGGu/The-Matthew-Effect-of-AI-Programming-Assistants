use std::collections::HashSet;

impl Solution {
    pub fn longest_consecutive(nums: Vec<i32>) -> i32 {
        let num_set: HashSet<i32> = nums.iter().cloned().collect();
        let mut max_len = 0;

        for &num in &nums {
            if !num_set.contains(&(num - 1)) {
                let mut current_num = num;
                let mut current_len = 1;

                while num_set.contains(&(current_num + 1)) {
                    current_num += 1;
                    current_len += 1;
                }

                max_len = max_len.max(current_len);
            }
        }

        max_len
    }
}