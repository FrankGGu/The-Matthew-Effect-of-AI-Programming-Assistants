use std::collections::VecDeque;

impl Solution {
    pub fn continuous_subarrays(nums: Vec<i32>) -> i64 {
        let mut res = 0;
        let mut min_deque = VecDeque::new();
        let mut max_deque = VecDeque::new();
        let mut left = 0;

        for right in 0..nums.len() {
            while !min_deque.is_empty() && nums[*min_deque.back().unwrap()] > nums[right] {
                min_deque.pop_back();
            }
            min_deque.push_back(right);

            while !max_deque.is_empty() && nums[*max_deque.back().unwrap()] < nums[right] {
                max_deque.pop_back();
            }
            max_deque.push_back(right);

            while nums[*max_deque.front().unwrap()] - nums[*min_deque.front().unwrap()] > 2 {
                left += 1;
                while !min_deque.is_empty() && *min_deque.front().unwrap() < left {
                    min_deque.pop_front();
                }
                while !max_deque.is_empty() && *max_deque.front().unwrap() < left {
                    max_deque.pop_front();
                }
            }

            res += (right - left + 1) as i64;
        }

        res
    }
}