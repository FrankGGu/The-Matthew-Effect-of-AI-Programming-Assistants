impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn sort_by_parity(mut nums: Vec<i32>) -> Vec<i32> {
        let mut even = VecDeque::new();
        let mut odd = VecDeque::new();

        for num in nums.iter() {
            if num % 2 == 0 {
                even.push_back(*num);
            } else {
                odd.push_back(*num);
            }
        }

        let mut result = Vec::new();
        while let Some(e) = even.pop_front() {
            result.push(e);
        }
        while let Some(o) = odd.pop_front() {
            result.push(o);
        }

        result
    }
}
}