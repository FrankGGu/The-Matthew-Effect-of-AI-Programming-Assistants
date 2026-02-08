use std::collections::VecDeque;

impl Solution {
    pub fn max_sliding_window(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut result = Vec::new();
        let mut deque = VecDeque::new();

        for i in 0..nums.len() {
            while let Some(&front) = deque.front() {
                if front <= i as i32 - k as i32 {
                    deque.pop_front();
                } else {
                    break;
                }
            }

            while let Some(&back) = deque.back() {
                if nums[back as usize] <= nums[i] {
                    deque.pop_back();
                } else {
                    break;
                }
            }

            deque.push_back(i as i32);

            if i as usize >= k - 1 {
                result.push(nums[deque.front().unwrap() as usize]);
            }
        }

        result
    }
}