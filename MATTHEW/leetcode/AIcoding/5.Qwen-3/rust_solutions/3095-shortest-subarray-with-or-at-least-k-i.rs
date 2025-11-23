impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_subarray_length(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut min_len = n as i32 + 1;
        let mut queue = VecDeque::new();

        for i in 0..n {
            let num = nums[i];
            let mut new_queue = VecDeque::new();
            while let Some((mask, j)) = queue.pop_front() {
                let new_mask = mask | num;
                if new_mask >= k {
                    min_len = std::cmp::min(min_len, (i - j + 1) as i32);
                } else {
                    new_queue.push_back((new_mask, j));
                }
            }
            new_queue.push_back((num, i));
            queue = new_queue;
        }

        if min_len <= n as i32 {
            min_len
        } else {
            -1
        }
    }
}
}