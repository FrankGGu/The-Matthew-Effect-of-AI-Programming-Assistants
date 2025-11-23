impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut operations = 0;
        let mut queue = VecDeque::new();

        for &num in &nums {
            if num != k {
                queue.push_back(num);
            }
        }

        while let Some(mut current) = queue.pop_front() {
            if current == k {
                continue;
            }

            if current < k {
                current += 1;
                operations += 1;
                queue.push_back(current);
            } else {
                current -= 1;
                operations += 1;
                queue.push_back(current);
            }
        }

        operations
    }
}
}