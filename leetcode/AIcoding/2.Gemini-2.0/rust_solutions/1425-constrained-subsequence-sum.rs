use std::collections::VecDeque;

impl Solution {
    pub fn constrained_subset_sum(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut deque: VecDeque<usize> = VecDeque::new();
        let mut max_sum = i32::MIN;

        for i in 0..n {
            if !deque.is_empty() && (i as i32 - deque.front().unwrap().clone() as i32) > k {
                deque.pop_front();
            }

            dp[i] = nums[i];
            if !deque.is_empty() {
                dp[i] = dp[i].max(nums[i] + dp[*deque.front().unwrap()]);
            }

            while !deque.is_empty() && dp[*deque.back().unwrap()] <= dp[i] {
                deque.pop_back();
            }

            if dp[i] > 0 {
                deque.push_back(i);
            }

            max_sum = max_sum.max(dp[i]);
        }

        max_sum
    }
}