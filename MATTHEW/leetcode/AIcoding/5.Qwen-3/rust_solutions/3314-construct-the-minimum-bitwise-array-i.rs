impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_bitwise_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut dq = VecDeque::new();
        for &num in &nums {
            dq.push_back(num);
        }
        let mut result = vec![];
        while dq.len() > 1 {
            let mut new_dq = VecDeque::new();
            for i in 0..dq.len() - 1 {
                let a = dq[i];
                let b = dq[i + 1];
                new_dq.push_back(a | b);
            }
            dq = new_dq;
        }
        while let Some(num) = dq.pop_front() {
            result.push(num);
        }
        result
    }
}
}