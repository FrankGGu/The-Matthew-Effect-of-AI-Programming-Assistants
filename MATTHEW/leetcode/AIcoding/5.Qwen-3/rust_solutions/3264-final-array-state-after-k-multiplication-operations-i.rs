impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn final_array_state(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut q = VecDeque::new();
        for num in nums {
            q.push_back(num);
        }

        for _ in 0..k {
            if let Some(front) = q.pop_front() {
                q.push_back(front * 2);
            }
        }

        q.into_iter().collect()
    }
}
}