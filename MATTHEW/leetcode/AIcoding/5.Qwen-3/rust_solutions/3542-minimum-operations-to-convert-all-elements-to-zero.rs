impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut q = VecDeque::new();
        for &num in &nums {
            q.push_back(num);
        }

        let mut operations = 0;

        while !q.is_empty() {
            let mut new_q = VecDeque::new();
            let mut has_non_zero = false;

            while let Some(mut num) = q.pop_front() {
                if num != 0 {
                    has_non_zero = true;
                    num -= 1;
                }
                if num != 0 {
                    new_q.push_back(num);
                }
            }

            if has_non_zero {
                operations += 1;
            }

            q = new_q;
        }

        operations
    }
}
}