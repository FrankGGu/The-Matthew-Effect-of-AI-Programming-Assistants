use std::collections::VecDeque;

impl Solution {
    pub fn longest_subarray(nums: Vec<i32>, limit: i32) -> i32 {
        let mut max_deque: VecDeque<i32> = VecDeque::new();
        let mut min_deque: VecDeque<i32> = VecDeque::new();
        let mut left = 0;
        let mut right = 0;
        let mut max_len = 0;

        while right < nums.len() {
            while !max_deque.is_empty() && nums[*max_deque.back().unwrap() as usize] <= nums[right] {
                max_deque.pop_back();
            }
            max_deque.push_back(right as i32);

            while !min_deque.is_empty() && nums[*min_deque.back().unwrap() as usize] >= nums[right] {
                min_deque.pop_back();
            }
            min_deque.push_back(right as i32);

            while nums[*max_deque.front().unwrap() as usize] - nums[*min_deque.front().unwrap() as usize] > limit {
                if *max_deque.front().unwrap() as usize == left {
                    max_deque.pop_front();
                }
                if *min_deque.front().unwrap() as usize == left {
                    min_deque.pop_front();
                }
                left += 1;
            }

            max_len = max_len.max(right - left + 1);
            right += 1;
        }

        max_len as i32
    }
}