use std::collections::VecDeque;

impl Solution {
    pub fn find_x_sum_of_all_k_long_subarrays_ii(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k = k as usize;

        if k == 0 || n < k {
            return Vec::new();
        }

        let mut results: Vec<i32> = Vec::new();
        let mut max_deque: VecDeque<usize> = VecDeque::new();
        let mut min_deque: VecDeque<usize> = VecDeque::new();

        for i in 0..n {
            if let Some(&front_idx) = max_deque.front() {
                if front_idx <= i - k {
                    max_deque.pop_front();
                }
            }
            if let Some(&front_idx) = min_deque.front() {
                if front_idx <= i - k {
                    min_deque.pop_front();
                }
            }

            while let Some(&back_idx) = max_deque.back() {
                if nums[back_idx] <= nums[i] {
                    max_deque.pop_back();
                } else {
                    break;
                }
            }
            max_deque.push_back(i);

            while let Some(&back_idx) = min_deque.back() {
                if nums[back_idx] >= nums[i] {
                    min_deque.pop_back();
                } else {
                    break;
                }
            }
            min_deque.push_back(i);

            if i >= k - 1 {
                let max_val = nums[*max_deque.front().unwrap()];
                let min_val = nums[*min_deque.front().unwrap()];
                results.push(max_val + min_val);
            }
        }

        results
    }
}