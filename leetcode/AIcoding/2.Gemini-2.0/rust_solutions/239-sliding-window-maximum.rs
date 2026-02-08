use std::collections::VecDeque;

impl Solution {
    pub fn max_sliding_window(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut deque: VecDeque<usize> = VecDeque::new();
        let mut result: Vec<i32> = Vec::new();

        for i in 0..nums.len() {
            while !deque.is_empty() && nums[deque.back().unwrap()] <= nums[i] {
                deque.pop_back();
            }

            deque.push_back(i);

            if deque.front().unwrap() <= &(i - k) {
                deque.pop_front();
            }

            if i >= k - 1 {
                result.push(nums[deque.front().unwrap()]);
            }
        }

        result
    }
}