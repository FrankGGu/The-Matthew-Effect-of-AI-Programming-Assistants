use std::collections::VecDeque;

impl Solution {
    pub fn maximum_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut max_sum = i32::MIN;
        let mut min_sum = i32::MAX;
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        let mut deque = VecDeque::new();
        for i in 0..=n {
            while !deque.is_empty() && i - deque.front().unwrap() > k {
                deque.pop_front();
            }
            if !deque.is_empty() {
                let sum = prefix[i] - prefix[*deque.front().unwrap()];
                max_sum = max_sum.max(sum);
                min_sum = min_sum.min(sum);
            }
            while !deque.is_empty() && prefix[i] <= prefix[*deque.back().unwrap()] {
                deque.pop_back();
            }
            deque.push_back(i);
        }
        max_sum + min_sum
    }
}