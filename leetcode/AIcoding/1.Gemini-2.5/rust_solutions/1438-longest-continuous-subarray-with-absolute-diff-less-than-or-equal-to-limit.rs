use std::collections::VecDeque;

impl Solution {
    pub fn longest_subarray(nums: Vec<i32>, limit: i32) -> i32 {
        let mut min_deque: VecDeque<i32> = VecDeque::new();
        let mut max_deque: VecDeque<i32> = VecDeque::new();
        let mut left = 0;
        let mut max_len = 0;

        for right in 0..nums.len() {
            let current_num = nums[right];

            while let Some(&back_val) = max_deque.back() {
                if back_val < current_num {
                    max_deque.pop_back();
                } else {
                    break;
                }
            }
            max_deque.push_back(current_num);

            while let Some(&back_val) = min_deque.back() {
                if back_val > current_num {
                    min_deque.pop_back();
                } else {
                    break;
                }
            }
            min_deque.push_back(current_num);

            while max_deque.front().unwrap() - min_deque.front().unwrap() > limit {
                if nums[left] == *max_deque.front().unwrap() {
                    max_deque.pop_front();
                }
                if nums[left] == *min_deque.front().unwrap() {
                    min_deque.pop_front();
                }
                left += 1;
            }

            max_len = max_len.max(right - left + 1);
        }

        max_len as i32
    }
}