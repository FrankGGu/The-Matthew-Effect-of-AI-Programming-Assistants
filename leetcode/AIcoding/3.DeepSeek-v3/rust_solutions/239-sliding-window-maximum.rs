use std::collections::VecDeque;

impl Solution {
    pub fn max_sliding_window(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut deque = VecDeque::new();
        let mut result = Vec::new();

        for i in 0..nums.len() {
            while let Some(&back) = deque.back() {
                if nums[back] <= nums[i] {
                    deque.pop_back();
                } else {
                    break;
                }
            }
            deque.push_back(i);

            if i >= k - 1 {
                while let Some(&front) = deque.front() {
                    if front <= i - k {
                        deque.pop_front();
                    } else {
                        break;
                    }
                }
                result.push(nums[*deque.front().unwrap()]);
            }
        }

        result
    }
}