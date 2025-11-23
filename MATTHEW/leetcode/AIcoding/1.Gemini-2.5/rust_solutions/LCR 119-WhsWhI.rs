use std::collections::HashSet;

impl Solution {
    pub fn longest_consecutive(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let num_set: HashSet<i32> = nums.into_iter().collect();
        let mut max_len = 0;

        for &num in &num_set {
            // Check if 'num' is the start of a sequence
            // A number is the start of a sequence if 'num - 1' is not present in the set
            if !num_set.contains(&(num - 1)) {
                let mut current_num = num;
                let mut current_len = 1;

                // Count consecutive numbers
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