use std::collections::VecDeque;

impl Solution {
    pub fn longest_subarray(nums: Vec<i32>, limit: i32) -> i32 {
        let mut max_deque = VecDeque::new();
        let mut min_deque = VecDeque::new();
        let mut left = 0;
        let mut max_length = 0;

        for right in 0..nums.len() {
            while let Some(&last) = max_deque.back() {
                if last < nums[right] {
                    max_deque.pop_back();
                } else {
                    break;
                }
            }
            max_deque.push_back(nums[right]);

            while let Some(&last) = min_deque.back() {
                if last > nums[right] {
                    min_deque.pop_back();
                } else {
                    break;
                }
            }
            min_deque.push_back(nums[right]);

            while max_deque.front().unwrap() - min_deque.front().unwrap() > limit {
                if nums[left] == *max_deque.front().unwrap() {
                    max_deque.pop_front();
                }
                if nums[left] == *min_deque.front().unwrap() {
                    min_deque.pop_front();
                }
                left += 1;
            }
            max_length = max_length.max(right - left + 1);
        }

        max_length
    }
}