impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn is_not_bomb(mut code: Vec<i32>, k: i32) -> Vec<i32> {
        let n = code.len();
        if k == 0 {
            return vec![0; n];
        }
        let mut result = vec![0; n];
        let mut queue = VecDeque::new();
        let mut sum = 0;
        for i in 0..n {
            queue.push_back(code[i]);
            sum += code[i];
            if i >= k as usize {
                sum -= queue.pop_front().unwrap();
            }
            if i >= k as usize - 1 {
                result[i] = sum;
            }
        }
        result
    }
}

pub struct Solution;
}