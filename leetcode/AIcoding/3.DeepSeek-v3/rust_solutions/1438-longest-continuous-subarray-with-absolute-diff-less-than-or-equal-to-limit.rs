use std::collections::VecDeque;

impl Solution {
    pub fn longest_subarray(nums: Vec<i32>, limit: i32) -> i32 {
        let mut max_deque = VecDeque::new();
        let mut min_deque = VecDeque::new();
        let mut left = 0;
        let mut result = 0;

        for right in 0..nums.len() {
            while !max_deque.is_empty() && nums[*max_deque.back().unwrap()] <= nums[right] {
                max_deque.pop_back();
            }
            max_deque.push_back(right);

            while !min_deque.is_empty() && nums[*min_deque.back().unwrap()] >= nums[right] {
                min_deque.pop_back();
            }
            min_deque.push_back(right);

            while nums[*max_deque.front().unwrap()] - nums[*min_deque.front().unwrap()] > limit {
                left += 1;
                while !max_deque.is_empty() && *max_deque.front().unwrap() < left {
                    max_deque.pop_front();
                }
                while !min_deque.is_empty() && *min_deque.front().unwrap() < left {
                    min_deque.pop_front();
                }
            }

            result = result.max(right - left + 1);
        }

        result as i32
    }
}